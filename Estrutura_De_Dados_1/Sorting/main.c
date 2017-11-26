/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Joaov
 *
 * Created on 26 de Novembro de 2017, 15:06
 */

#include <stdio.h>
#include <stdlib.h>
#include "Default.h"

/** Tamanho do array */
#define ARR_SIZE 5
#define NEW_ARR {3, 1, 5, 7, 4} /*5*/
//#define NEW_ARR {3, 0, 1, 8, 7, 2, 5, 4, 9, 6, 2} /*11*/

void bubbleSort(int arr[], int arraySize);
void selectionSort(int arr[], int arraySize);
void insertionSort(int arr[], int arraySize);

void mergeSort(int arr[], int arraySize);

// Função auxiliar para trocar os valores de 2 posições do array
void swapValue(int *arr, int idxA, int idxB);

/*
 * Main Entry point
 */
int main(int argc, char** argv) {

    /** Array inicial */
    int arr[ARR_SIZE] = NEW_ARR;

    printf("Antes:\n");
    printaArray(arr, ARR_SIZE);

    mergeSort(arr, ARR_SIZE);
    //    selectionSort(arr, ARR_SIZE);
    //    insertionSort(arr, ARR_SIZE);
    //    bubbleSort(arr, ARR_SIZE);

    printf("\nDepois:\n");
    printaArray(arr, ARR_SIZE);



    printf("\n");
    return (EXIT_SUCCESS);
}

void mergeSort(int arr[], int arraySize) {
    if (arraySize <= 1) return;
    // Metade do array
    int half = arraySize / 2;
    // Dois subarrays
    int a1[half];
    int a2[half];
    // Inicializa os subarrays
    for (int i = 0; i < half; i++) a1[i] = arr[i];
    for (int i = half; i < arraySize; i++) a2[i] = arr[i];
    // Realiza o sort nos 2 arrays
    mergeSort(a1);
    mergeSort(a2);

}

/**
 * Bubble Sort :D
 * 
 * @param arr
 * @param arraySize
 */
void bubbleSort(int arr[], int arraySize) {
    for (int i = 0; i < arraySize; i++) {
        for (int k = 0; k < arraySize; k++) {
            if (arr[i] < arr[k]) {
                swapValue(arr, i, k);
            }
        }
    }
}

void selectionSort(int arr[], int arraySize) {
    // Percorre o array do início guardando a posição inicial não ordenada
    for (int i = 0; i < arraySize; i++) {
        int iMenor = i;
        // Percorre o restante buscando a posição do menor
        for (int k = i + 1; k < arraySize; k++) {
            if (arr[k] < arr[iMenor]) {
                iMenor = k;
            }
        }
        // Troca a posição do menor elemento com o inicial
        if (i != iMenor) swapValue(arr, i, iMenor);
    }
}

/**
 * Insertion Sort :D
 * 
 * @param arr
 * @param arraySize
 */
void insertionSort(int arr[], int arraySize) {
    // Percorre o array a pt. da segunda posição
    for (int i = 1; i < arraySize; i++) {
        // Percorre decrescentemente a pt. da posição escolhida
        for (int k = i; k > 0; k--) {
            // Se o elemento for menor que o anterior, troca
            if (arr[k] < arr[k - 1]) {
                swapValue(arr, k, k - 1);
            }
        }
    }
}

/** 
 * Função auxiliar para realizar a troca de 2 elementos de posição
 */
void swapValue(int *arr, int idxA, int idxB) {
    int temp = *(arr + idxA);
    *(arr + idxA) = *(arr + idxB);
    *(arr + idxB) = temp;
}