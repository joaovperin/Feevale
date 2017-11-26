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
#include <limits.h>
#include "Default.h"

/** Tamanho do array */
#define ARR_SIZE 10
#define NEW_ARR {3, 0, 1, 8, 7, 2, 5, 4, 9, 6}

void bubbleSort(int arr[], int arraySize);
void selectionSort(int arr[], int arraySize);
void insertionSort(int arr[], int arraySize);
void mergeSort(int arr[], int arraySize);

void mergeSort_merge(int arr[], int p, int q, int r);
void mergeSort_ms(int arr[], int p, int r);

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

    printf("\nDepois:\n");
    printaArray(arr, ARR_SIZE);

    printf("\n");
    return (EXIT_SUCCESS);
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

/**
 * Selection Sort :D
 * 
 * @param arr
 * @param arraySize
 */
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
 * Merge Sort :D
 * 
 * @param arr
 * @param arraySize
 */
void mergeSort(int arr[], int arraySize) {
    mergeSort_ms(arr, 0, arraySize);
}

/**
 * Merge Sort - Função principal, recursiva (divide)
 * 
 * @param arr
 * @param arraySize
 */
void mergeSort_ms(int arr[], int p, int r) {
    // Se o tamanho for 1, já está ordenado
    if (p >= r) return;
    int half = (p + r) / 2;
    // Ordena recursivamente os subarrays
    mergeSort_ms(arr, p, half);
    mergeSort_ms(arr, half + 1, r);
    // Ordena o array principal realizando o merge
    mergeSort_merge(arr, p, half, r);
}

/**
 * Merge Sort - Função merge (conquer)
 * 
 * @param arr
 * @param arraySize
 */
void mergeSort_merge(int arr[], int p, int q, int r) {
    // Cria 2 subarrays para a esquerda e direita do array principal
    int leftSize = (q - p + 1), rightSize = (r - q);
    int left[leftSize + 1], right[rightSize + 1];
    // Inicializa os subarrays
    for (int idx = 0; idx <= leftSize; idx++) left[idx] = *(arr + p + idx - 1);
    for (int idx = 0; idx <= rightSize; idx++) right[idx] = *(arr + q + idx);
    left[leftSize + 1] = INT_MAX;
    right[rightSize + 1] = INT_MAX;
    // Realiza o merge dos subarrays no array principal
    int i = 1, j = 1;
    for (int idx = p; idx <= r; idx++) {
        if (left[i] <= right[j]) *(arr + idx) = left[i++];
        else *(arr + idx) = right[j++];
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