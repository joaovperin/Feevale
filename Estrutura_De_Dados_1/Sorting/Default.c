/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include <stdio.h>

/** Limpa o buffer do teclado */
void limpaBuffer() {
    fflush(stdin);
}

/** Printa um array */
void printaArray(int arr[], int arrSize) {
    if (arrSize <= 1) {
        printf("Array com tamanho inválido.\n");
        return;
    }
    for (int i = 0; i < arrSize; i++) {
        printf("P%02d:%3d\n", i + 1, arr[i]);
    }
}