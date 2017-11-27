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
#include <time.h>

void bubbleSort(int arr[], int arraySize);
void selectionSort(int arr[], int arraySize);
void insertionSort(int arr[], int arraySize);
void mergeSort(int arr[], int arraySize);

void mergeSort_merge(int arr[], int p, int q, int r);
void mergeSort_ms(int arr[], int p, int r);

// Função auxiliar para trocar os valores de 2 posições do array
void swapValue(int *arr, int idxA, int idxB);

// Funções auxiliares para controle de tempo
void timerOn();
void timerOff();
void timerPrint();
// Instâncias globais do clock para controle de benchmarking
clock_t clockStart, clockEnd;

#define OPT_EXIT '0'
#define OPT_BUBBLE '1'
#define OPT_SELECTION '2'
#define OPT_INSERTION '3'
#define OPT_MERGE '4'
#define OPT_TESTS '5'

/**
 * SIMULAÇÃO BUG MERGE:
 * 
 * Opção 4;
 * Array tamanho 12;
 */

#define SIZE_1 1  /*   1000 */
#define SIZE_2 5  /*  50000 */
#define SIZE_3 7  /* 100000 */
#define SIZE_4 12 /* 200000 */

void executaTesteComparacao();
void execTestesBubbleSort(int *arr, int mtz[], int arraySize);
void execTestesSelectionSort(int *arr, int mtz[], int arraySize);
void execTestesInsertionSort(int *arr, int mtz[], int arraySize);
void execTestesMergeSort(int *arr, int mtz[], int arraySize);

int aceitaTamanhoInicial();
char acceptMenu();
int* comeca(int arraySize, int mtz[]);
void finaliza(int *ptr);

/** Limpa o buffer do teclado */
void limpaBuffer();
/** Printa um array */
void printaArray(int arr[], int arrSize);
/** Troca o valor de 2 posições de um array */
void swapValue(int *arr, int idxA, int idxB);

/*
 * Main Entry point
 */
int main(int argc, char** argv) {
    // Inicializa gerador de aleatórios
    srand(time(NULL));
    // Opção Default = Bubble
    char opt = OPT_BUBBLE;
    // Se recebeu por linha de comando, atribui a opção
    if (argc == 2) {
        opt = (char) *(argv + 1)[0];
    } else {
        opt = acceptMenu();
    }
    // Se for pra encerrar o programa
    if (opt == OPT_EXIT) {
        printf("\nBye bye :D\n");
        return (EXIT_SUCCESS);
    }
    // Se for opção de comparação....
    if (opt == '5') {
        printf("\nIniciando testes de comparação...");
        executaTesteComparacao();
        printf("\n");
        return (EXIT_SUCCESS);
    }

    /** Array inicial */
    int arrayStartSize = aceitaTamanhoInicial();
    int arr[arrayStartSize];
    int arraySize = sizeof (arr) / sizeof (int);
    // Inicializa gerador de aleatórios
    srand(time(NULL));
    for (int i = 0; i < arraySize; i++) arr[i] = rand() % 1000;

    printaArray(arr, arraySize);
    timerOn();
    // Avalia a opção escolhida
    switch (opt) {
        case OPT_BUBBLE:
            printf("\nBubble Sort");
            bubbleSort(arr, arraySize);
            break;
        case OPT_SELECTION:
            printf("\nSelection Sort");
            selectionSort(arr, arraySize);
            break;
        case OPT_INSERTION:
            printf("\nInsertion Sort");
            insertionSort(arr, arraySize);
            break;
        case OPT_MERGE:
            printf("\nMerge Sort");
            mergeSort(arr, arraySize);
            break;
        default:
            printf("Opção não reconhecida.\n");
            break;
    }
    timerOff();
    timerPrint();
    putchar('\n');
    printaArray(arr, arraySize);

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

void execTestesBubbleSort(int *arr, int mtz[], int arraySize) {
    printf("\n** Tamanho do array: %06d", arraySize);
    arr = comeca(arraySize, mtz);
    bubbleSort(arr, arraySize);
    finaliza(arr);
}

void execTestesSelectionSort(int *arr, int mtz[], int arraySize) {
    printf("\n** Tamanho do array: %06d", arraySize);
    arr = comeca(arraySize, mtz);
    selectionSort(arr, arraySize);
    finaliza(arr);
}

void execTestesInsertionSort(int *arr, int mtz[], int arraySize) {
    printf("\n** Tamanho do array: %06d", arraySize);
    arr = arr = comeca(arraySize, mtz);
    insertionSort(arr, arraySize);
    finaliza(arr);
}

void execTestesMergeSort(int *arr, int mtz[], int arraySize) {
    printf("\n** Tamanho do array: %06d", arraySize);
    arr = arr = comeca(arraySize, mtz);
    mergeSort(arr, arraySize);
    finaliza(arr);
}

/**
 * Função responsável por exibir e aceitar o menu
 *
 * @return char
 */
char acceptMenu() {
    char tmp = '\0';
    printf("\n ***********:");
    printf("\n * %2c-Sair", OPT_EXIT);
    printf("\n * %2c-Bubble Sort", OPT_BUBBLE);
    printf("\n * %2c-Selection Sort", OPT_SELECTION);
    printf("\n * %2c-Insertion Sort", OPT_INSERTION);
    printf("\n * %2c-Merge Sort", OPT_MERGE);
    printf("\n * %2c-Testes Desempenho", OPT_TESTS);
    printf("\n ***********:");
    do {
        limpaBuffer();
        printf("\nEscolha: ");
        scanf("%c", &tmp);
    } while (tmp != '1' && tmp != '2' && tmp != '3' && tmp != '4' && tmp != '5' && tmp != '0');
    return tmp;
}

int aceitaTamanhoInicial() {
    int tam = -1;
    do {
        printf("\nDiga o tamanho do array: ");
        limpaBuffer();
        scanf("%6d", &tam);
    } while (tam <= 0);
    return tam;
}

void executaTesteComparacao() {
    /** Array matriz */
    int mtz[SIZE_4];
    int *arr = NULL;
    int arraySize = sizeof (mtz) / sizeof (int);
    // Popula o array matriz com dados iniciais
    for (int i = 0; i < arraySize; i++) mtz[i] = rand() % 1000;

    // *********** BUBBLE ************* //
    printf("\n\nBubble Sort");
    execTestesBubbleSort(arr, mtz, SIZE_1);
    execTestesBubbleSort(arr, mtz, SIZE_2);
    execTestesBubbleSort(arr, mtz, SIZE_3);
    execTestesBubbleSort(arr, mtz, SIZE_4);
    // *********** SELECTION ************* //
    printf("\n\nSelection Sort");
    execTestesSelectionSort(arr, mtz, SIZE_1);
    execTestesSelectionSort(arr, mtz, SIZE_2);
    execTestesSelectionSort(arr, mtz, SIZE_3);
    execTestesSelectionSort(arr, mtz, SIZE_4);
    // *********** INSERTION ************* //
    printf("\n\nInsertion Sort");
    execTestesInsertionSort(arr, mtz, SIZE_1);
    execTestesInsertionSort(arr, mtz, SIZE_2);
    execTestesInsertionSort(arr, mtz, SIZE_3);
    execTestesInsertionSort(arr, mtz, SIZE_4);
    // *********** SELECTION ************* //
    printf("\n\nSelection Sort");
    execTestesSelectionSort(arr, mtz, SIZE_1);
    execTestesSelectionSort(arr, mtz, SIZE_2);
    execTestesSelectionSort(arr, mtz, SIZE_3);
    execTestesSelectionSort(arr, mtz, SIZE_4);
    // *********** MERGE ************* //
    printf("\n\nMerge Sort");
    execTestesMergeSort(arr, mtz, SIZE_1);
    execTestesMergeSort(arr, mtz, SIZE_2);
    execTestesMergeSort(arr, mtz, SIZE_3);
    execTestesMergeSort(arr, mtz, SIZE_4);
}

/** Limpa o buffer do teclado */
void limpaBuffer() {
    fflush(stdin);
}

/** Printa um array */
void printaArray(int *arr, int arrSize) {
    if (arrSize <= 1) {
        printf("Array com tamanho inválido.\n");
        return;
    }
    for (int i = 0; i < arrSize; i++) {
        printf("P%03d:%4d\n", i + 1, *(arr + i));
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

void timerOn() {
    clockStart = clock();
}

void timerOff() {
    clockEnd = clock();
}

void timerPrint() {
    printf("\nTempo decorrido: %dms", (clockEnd - clockStart) / (CLOCKS_PER_SEC / 1000));
}

int* comeca(int arraySize, int mtz[]) {
    int *ptr = (int*) calloc(arraySize, sizeof (int));
    for (int i = 0; i < arraySize; i++) *(ptr + i) = mtz[i];
    timerOn();
    return ptr;
}

void finaliza(int *ptr) {
    timerOff();
    timerPrint();
    free(ptr);
}