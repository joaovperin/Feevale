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

#define SIZE_1   1000    /*   1000 */
#define SIZE_2  50000   /*  50000 */
#define SIZE_3 100000  /* 100000 */
#define SIZE_4 200000 /* 200000 */

/** Limite de tamanho do array */
#define LIMIT_SIZE 260548

void executaTesteComparacao();
void execTestesBubbleSort(int *arr, int mtz[], int arraySize);
void execTestesSelectionSort(int *arr, int mtz[], int arraySize);
void execTestesInsertionSort(int *arr, int mtz[], int arraySize);
void execTestesMergeSort(int *arr, int mtz[], int arraySize);

int aceitaTamanhoInicial();
char acceptMenu();
int isMenuValido(char l);
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
        // Valida o menu
        if (!isMenuValido(opt)) {
            printf("Menu inválido: %c\nEncerrando programa.\n", opt);
            return (EXIT_SUCCESS);
        }
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
    int arraySize = aceitaTamanhoInicial();
    int arr[arraySize + 1];
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
    // teste implementação 2 :/
    int i = 1, k;
    while (i < arraySize) {
        k = i;
        while (k > 0 && arr[k] < arr[k - 1]) {
            swapValue(arr, k, k - 1);
            k--;
        }
        i++;
    }
    return;
    // Percorre o array a pt. da segunda posição
    for (int i = 1; i < arraySize; i++) {
        // Percorre decrescentemente a pt. da posição escolhida
        // reordenando os elementos subsequentes
        for (int k = i; k > 0 && arr[k] < arr[k - 1]; k--) {
            // Se o elemento for menor que o anterior, troca
            swapValue(arr, k, k - 1);
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
    arr = comeca(arraySize, mtz);
    insertionSort(arr, arraySize);
    finaliza(arr);
}

void execTestesMergeSort(int *arr, int mtz[], int arraySize) {
    printf("\n** Tamanho do array: %06d", arraySize);
    arr = comeca(arraySize, mtz);
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
    } while (!isMenuValido(tmp));
    return tmp;
}

/**
 * Aceita o tamanho inicial do array
 *
 * @return int
 */
int aceitaTamanhoInicial() {
    int tam = -1;
    do {
        printf("\nDiga o tamanho do array: ");
        limpaBuffer();
        scanf("%6d", &tam);
    } while (tam <= 0 || tam > LIMIT_SIZE);
    return tam;
}

/**
 * Executa os testes de comparação
 */
void executaTesteComparacao() {
    /** Array matriz */
    int mtz[SIZE_4];
    int *arr = NULL;
    int arraySize = sizeof (mtz) / sizeof (int);
    // Popula o array matriz com dados iniciais
    for (int i = 0; i < arraySize; i++) mtz[i] = rand() % 1000;
    // *********** BUBBLE ************* //
    printf("\n\n-> Bubble Sort");
    execTestesBubbleSort(arr, mtz, SIZE_1);
    execTestesBubbleSort(arr, mtz, SIZE_2);
    execTestesBubbleSort(arr, mtz, SIZE_3);
    execTestesBubbleSort(arr, mtz, SIZE_4);
    // *********** SELECTION ************* //
    printf("\n\n-> Selection Sort");
    execTestesSelectionSort(arr, mtz, SIZE_1);
    execTestesSelectionSort(arr, mtz, SIZE_2);
    execTestesSelectionSort(arr, mtz, SIZE_3);
    execTestesSelectionSort(arr, mtz, SIZE_4);
    // *********** INSERTION ************* //
    printf("\n\n-> Insertion Sort");
    execTestesInsertionSort(arr, mtz, SIZE_1);
    execTestesInsertionSort(arr, mtz, SIZE_2);
    execTestesInsertionSort(arr, mtz, SIZE_3);
    execTestesInsertionSort(arr, mtz, SIZE_4);
    // *********** MERGE ************* //
    printf("\n\nMerge Sort");
    execTestesMergeSort(arr, mtz, SIZE_1);
    execTestesMergeSort(arr, mtz, SIZE_2);
    execTestesMergeSort(arr, mtz, SIZE_3);
    execTestesMergeSort(arr, mtz, SIZE_4);
}

/**
 * Verifica/confere se é um menu válido
 *
 * @param l letra
 * @return int
 */
int isMenuValido(char l) {
    return !(l != '1' && l != '2' && l != '3' && l != '4' && l != '5' && l != '0');
}

/** Limpa o buffer do teclado */
void limpaBuffer() {
    fflush(stdin);
}

/** Printa um array */
void printaArray(int *arr, int arrSize) {
    if (arrSize > 15) return;
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

/**
 * Inicia o timer
 */
void timerOn() {
    clockStart = clock();
}

/**
 * Finaliza o timer
 */
void timerOff() {
    clockEnd = clock();
}

/**
 * Printa o tempo decorrido
 */
void timerPrint() {
    printf("\nTempo decorrido: %dms", (clockEnd - clockStart) / (CLOCKS_PER_SEC / 1000));
}

/**
 * Inicializa uma execução de comparação
 *
 * @param ptr
 */
int* comeca(int arraySize, int mtz[]) {
    int *ptr = (int*) calloc(arraySize + 1, sizeof (int));
    for (int i = 0; i < arraySize; i++) *(ptr + i) = mtz[i];
    timerOn();
    return ptr;
}

/**
 * Finaliza uma execução de comparação
 *
 * @param ptr
 */
void finaliza(int *ptr) {
    timerOff();
    timerPrint();
    free(ptr);
}