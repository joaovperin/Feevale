/*
 * Projeto
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */

/*
 * File:   lista-linear-encadeada.h
 * Author: Perin
 *
 * Created on 5 de Outubro de 2017, 15:25
 */

/**
 * 1) Criar uma estrutura com no mínimo dois membros, um valor inteiro e um vetor de caracteres. Por exemplo:
 *
 * struct cliente {
 *  int mat;
 *  char nome[40];
 * };
 *
 * struct elemento {
 *  struct cliente cli;
 *  struct elemento *prox;
 * }
 *
 * 2) Implementar as seguintes funções:
 *
 * a) Criar uma lista;                                        = ls_create();
 * b) Inserir um nodo no início da lista;                     = ls_preppend();
 * c) Inserir um nodo no final da lista;                      = ls_append();
 * d) Remover um nodo da lista;                               = ls_remove();
 * e) Buscar um nodo na lista a partir da matrícula do aluno; = ls_readKey();
 * f) Imprimir a lista;                                       = ls_printAll();
 * g) Limpar a lista;                                         = ls_close();
 * h) Verificar se a lista está vazia.                        = ls_isEmpty();
 *
 * 3) Implementar uma função que insira os nodos de modo ordenado (crescente), considerando a matrícula;
 *
 * 4) Implementar uma função que insira os nodos de modo ordenado (decrescente), considerando a matrícula ;
 *
 */

#ifndef LISTA_LINEAR_ENCADEADA_H
#define LISTA_LINEAR_ENCADEADA_H

#ifdef __cplusplus
extern "C" {
#endif

    // Tamanho da descrição dos produtos
#define PROD_DESC_LEN 30

    /**
     * Estrutura de produtos
     */
    struct Produto {
        int codigo;
        char *descricao;
    };
    typedef struct Produto Produto;

    /**
     * Estrutura de um nodo da lista
     */
    struct LinkedListNode {
        Produto e;
        struct LinkedListNode *next;
    };
    typedef struct LinkedListNode LinkedListNode;

    // Funções de manipulação da lista
    LinkedListNode* ls_create();
    LinkedListNode* ls_preppend(LinkedListNode *p, Produto prod);
    LinkedListNode* ls_append(LinkedListNode *p, Produto prod);
    LinkedListNode* ls_remove(LinkedListNode *head, int cod);
    LinkedListNode* ls_readKey(LinkedListNode *p, int cod);

    LinkedListNode* ls_insertAsc(LinkedListNode *p, Produto prod);
    LinkedListNode* ls_insertDesc(LinkedListNode *p, Produto prod);

    // Funções de manipulação da lista
    void ls_printAll(LinkedListNode *p);
    void ls_close(LinkedListNode *head);
    int ls_isEmpty(LinkedListNode *head);

    // Funções auxiliares de elementos da lista
    Produto criaProduto(int cod, char valor[]);
    void printaProduto(Produto e);

    // Funções auxiliares do programa
    LinkedListNode* createNewListWithValues();
    void limpaBuffer();

#ifdef __cplusplus
}
#endif

#endif /* LISTA_LINEAR_ENCADEADA_H */

