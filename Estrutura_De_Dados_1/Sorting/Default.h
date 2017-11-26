/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Default.h
 * Author: Joaov
 *
 * Created on 26 de Novembro de 2017, 15:11
 */

#ifndef DEFAULT_H
#define DEFAULT_H

#ifdef __cplusplus
extern "C" {
#endif
    /** Limpa o buffer do teclado */
    void limpaBuffer();
    /** Printa um array */
    void printaArray(int arr[], int arrSize);
    /** Troca o valor de 2 posições de um array */
    void swapValue(int *arr, int idxA, int idxB);

#ifdef __cplusplus
}
#endif

#endif /* DEFAULT_H */

