#!/usr/bin/env python3
import random
import cv2
import model
import numpy as np
import warnings
import os
import glob
warnings.filterwarnings("ignore")

# Disable futile warnings
os.environ.setdefault('TF_CPP_MIN_LOG_LEVEL', '2')

BASE_PATH = '/content/gdrive/My Drive/Colab Notebooks/cars_detector/'
WEIGHT_PATH = BASE_PATH + "/weights/yolo-voc.1.0.h5"
INPUT_IMG_PATH = BASE_PATH + "/images/"
INPUT_IMG_MASK = "*.jpg"

# Some path validations
if not os.path.isdir(BASE_PATH):
    raise Exception("Base directory '{}' does not exist. Please, create and move things inside.".format(BASE_PATH))

if not os.path.isfile(WEIGHT_PATH):
    raise Exception("Please, put your trained weights file at the '{}' path.".format(WEIGHT_PATH))

if not os.path.isdir(INPUT_IMG_PATH) or glob.glob(INPUT_IMG_PATH + INPUT_IMG_MASK) == []:
    raise Exception("Please, put your input image(s) at the '{}' path, with name according to mask '{}'.".format(INPUT_IMG_PATH, INPUT_IMG_MASK))

random.seed(1)

class BoundBox:
    def __init__(self, x, y, w, h, scale=None, classes_scores=None):
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.scale = scale
        # Score of the bounding box
        self.classes_scores = classes_scores
        self.label_idx = -1
        self.score = -1

    def get_label_idx(self):
        if self.label_idx == -1:
            self.label_idx = np.argmax(self.classes_scores)
        return self.label_idx

    def get_score(self):
        if self.score == -1:
            self.score = self.classes_scores[self.get_label_idx()]
        return self.score

    def __str__(self):
        return "X:{} Y:{} W:{} H:{} C:{}".format(self.x, self.y, self.w, self.h, self.get_label_idx())


def bbox_iou(box1, box2):
    x1_min = box1.x - box1.w / 2
    x1_max = box1.x + box1.w / 2
    y1_min = box1.y - box1.h / 2
    y1_max = box1.y + box1.h / 2

    x2_min = box2.x - box2.w / 2
    x2_max = box2.x + box2.w / 2
    y2_min = box2.y - box2.h / 2
    y2_max = box2.y + box2.h / 2

    intersect_w = interval_overlap([x1_min, x1_max], [x2_min, x2_max])
    intersect_h = interval_overlap([y1_min, y1_max], [y2_min, y2_max])
    intersect = intersect_w * intersect_h
    union = box1.w * box1.h + box2.w * box2.h - intersect

    return float(intersect) / union


def interval_overlap(interval_a, interval_b):
    x1, x2 = interval_a
    x3, x4 = interval_b

    if x3 < x1:
        if x4 < x1:
            return 0
        else:
            return min(x2, x4) - x1
    else:
        if x2 < x3:
            return 0
        else:
            return min(x2, x4) - x3


def sigmoid(x):
    return 1. / (1. + np.exp(-x))


def softmax(x):
    e_x = np.exp(x - np.max(x))
    return e_x / e_x.sum(axis=0)  # only difference


def mergeset_images(src_image, x, y, dest_image):
    if x < 0:
        src_image = src_image[:, abs(x):]
        x = 0

    if y < 0:
        src_image = src_image[abs(y):, :]
        y = 0

    nh, nw = dest_image.shape[:2]
    oh, ow = src_image.shape[:2]

    aw = nw - x
    ah = nh - y

    if ow > aw:
        src_image = src_image[:, :aw]
        ow = aw

    if oh > ah:
        src_image = src_image[:ah, :]
        oh = ah

    dest_image[y:y + oh, x:x + ow] = src_image
    return dest_image


def scale_image(im_data, w, h):
    im_h, im_w, z = im_data.shape
    wp = w / float(im_w)
    hp = h / float(im_h)
    if wp < hp:
        nw = w
        nh = (im_h * nw) // im_w
    else:
        nh = h
        nw = (im_w * nh) // im_h

    return (nw, nh)


def letter(im_data, w, h, color=127):
    n_shape = scale_image(im_data, w, h)
    im_dest = (np.ones((h, w, 3)) * color).astype(np.uint8)
    im_data = cv2.resize(
        im_data, (n_shape[0], n_shape[1]), interpolation=cv2.INTER_NEAREST)
    x = (im_dest.shape[1] - im_data.shape[1]) // 2
    y = (im_dest.shape[0] - im_data.shape[0]) // 2
    im_dest = mergeset_images(im_data, x, y, im_dest)
    return im_dest


def unletter_boxes(boxes, out_img, input_w, input_h):
    dim_change = scale_image(out_img, input_w, input_h)
    w_change = input_w - dim_change[0]
    h_change = input_h - dim_change[1]

    for box in boxes:
        x = (box.x * input_w) - w_change / 2.0
        y = (box.y * input_h) - h_change / 2.0
        w = box.w * input_w
        h = box.h * input_h

        box.x = x / (input_w - w_change)
        box.w = w / (input_w - w_change)
        box.y = y / (input_h - h_change)
        box.h = h / (input_h - h_change)

def detect_image(im_name, im_data):
    print("*** Imagem de entrada '{}'.".format(im_name))
    im_h, im_w = im_data.shape[:2]
    im_out = im_data.copy()
    im_data = letter(im_data, 416, 416)
    im_data = im_data[:, :, ::-1]
    im_data = im_data.astype(np.float32).reshape((1, 416, 416, 3))
    im_data /= 255.0
    fake_boxes = np.zeros((1, 1, 1, 1, 15, 4))
    fake_anchors = np.zeros((1, 13, 13, 5, 1))
    preds = net.predict([im_data, fake_boxes, fake_anchors],
                        batch_size=3, verbose=0)
    preds = preds[0].reshape((13, 13, 5, 25))
    dim, detectors, n_classes = (13, 5, NUM_CLASSES)
    boxes = []

    # Create and store the boxes
    for row in range(dim):
        for col in range(dim):
            for n in range(detectors):
                x, y = (sigmoid(preds[row, col, n, :2]) + [col, row]) / dim
                w, h = (np.exp(preds[row, col, n, 2:4])
                        * ANCHOR_VALUES[n]) / dim
                scale = sigmoid(preds[row, col, n, 4])
                classes_scores = softmax(preds[row, col, n, 5:]) * scale

                if np.sum(classes_scores * (classes_scores > THRESHOLD)) > 0:
                    box = BoundBox(x, y, w, h, scale, classes_scores)
                    boxes += [box]

    # Find best class for each box
    for c in range(NUM_CLASSES):
        sorted_indices = list(
            reversed(np.argsort([box.classes_scores[c] for box in boxes])))
        for i in range(len(sorted_indices)):
            index_i = sorted_indices[i]

            if boxes[index_i].classes_scores[c] == 0:
                continue
            else:
                for j in range(i + 1, len(sorted_indices)):
                    index_j = sorted_indices[j]

                    if bbox_iou(boxes[index_i], boxes[index_j]) >= THRESHOLD:
                        boxes[index_j].classes_scores[c] = 0

    boxes = [box for box in boxes if box.get_score() > THRESHOLD]
    unletter_boxes(boxes, im_out, 416, 416)

    # Count all the boxes with the car class
    num_cars = 0
    for box in boxes:
        labelName = CLASSES[box.get_label_idx()]
        if labelName == 'car' and box.get_score() >= THRESHOLD:
            num_cars += 1

    print("{} carros detectados na imagem de entrada.".format(num_cars))

if __name__ == "__main__":
    # Load the model
    ANCHORS = '1.08,1.19,  3.42,4.41,  6.63,11.38,  9.42,5.11,  16.62,10.52'
    CLASSES = ["aeroplane", "bicycle", "bird", "boat", "bottle", "bus", "car", "cat", "chair", "cow",
               "diningtable", "dog", "horse", "motorbike", "person", "pottedplant", "sheep", "sofa", "train", "tvmonitor"]
    NUM_CLASSES = len(CLASSES)
    THRESHOLD = .3

    ANCHOR_VALUES = np.reshape([float(ANCHORS.strip())
                               for ANCHORS in ANCHORS.split(',')], [5, 2])
    box_colors = [(int(random.random()*255), int(random.random() * 255),
                   int(random.random()*255)) for _ in range(NUM_CLASSES)]

    fe = model.FeatureExtractor()
    net = fe.yolo_convolutional_net()
    net.load_weights(WEIGHT_PATH)

    input_images_list = glob.glob(INPUT_IMG_PATH + INPUT_IMG_MASK)
    if len(input_images_list) == 0:
        print("No input image found at the specified path.")
    else:
        for input_image in input_images_list:
            im_name = input_image.split('/')[-1]
            im_data = cv2.imread(input_image)
            if im_data is not None:
                detect_image(im_name, im_data)
