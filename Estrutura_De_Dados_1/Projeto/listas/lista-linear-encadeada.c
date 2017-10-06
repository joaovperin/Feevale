/*
 * Projeto Lista Encadeada - Trabalho Feevale Estrutura de dados 1
 */
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <windows.h>

// Declaração das estruturas e prototipação dos métodos
#include "lista-linear-encadeada.h"
#define DEBUG 0

/**
 * Método auxiliar para testes
 */
LinkedListNode* ls_insert(LinkedListNode *p, Produto prod) {
    return ls_append(p, prod);
}

/**
 * Entry point principal
 *
 * @return int
 */
int main() {

    // Declaração e inicialização do nodo inicial
    LinkedListNode *head;
    head = ls_create();

    ls_printAll(head);
    putchar('\n');

    // Inserção de alguns elementos
    head = ls_insert(head, criaProduto(700, "perin 700"));
    head = ls_insert(head, criaProduto(900, "perin 900"));
    head = ls_insert(head, criaProduto(59, "perin 59"));
    head = ls_insert(head, criaProduto(59, "perin 59(2)"));
    head = ls_insert(head, criaProduto(800, "perin 800"));

    ls_printAll(head);
    putchar('\n');

    head = ls_remove(head, 59);

    // Printa todos os elementos da lista
    ls_printAll(head);
    putchar('\n');

    printf("\nFim.");
    return EXIT_SUCCESS;
}

/*
 * Insere um elemento em ordem crescente na lista
 */
LinkedListNode* ls_insertAsc(LinkedListNode *head, Produto prod) {
    // Se for uma lista vazia, adiciona no final
    if (head == NULL) {
        return ls_preppend(NULL, prod);
    }
    // Encontra a posição
    LinkedListNode* ant = NULL;
    LinkedListNode* it = head;
    while (it != NULL && (it -> e.codigo < prod.codigo)) {
        ant = it;
        it = it -> next;
    }
    // Se não possuir registro anterior, adiciona como Head
    if (ant == NULL) return ls_preppend(head, prod);
    // Cria um novo elemento e insere-o na lista
    LinkedListNode* newElm = (struct LinkedListNode *) malloc(sizeof (struct LinkedListNode));
    newElm -> e = prod;
    newElm -> next = ant -> next;
    ant -> next = newElm;
    return head;
}

/*
 * Insere um elemento em ordem decrescente na lista
 */
LinkedListNode* ls_insertDesc(LinkedListNode *head, Produto prod) {
    // Se for uma lista vazia, adiciona no final
    if (head == NULL) {
        return ls_preppend(head, prod);
    }
    // Encontra a posição
    LinkedListNode* it = head;
    LinkedListNode* ant = NULL;
    while (it -> next != NULL && (it -> e.codigo > prod.codigo)) {
        ant = it;
        it = it -> next;
    }
    // Se não possuir registro anterior, adiciona como Head
    if (ant == NULL) return (prod.codigo >= it -> e.codigo ?
            ls_preppend(head, prod) : ls_append(head, prod));
    // Cria um novo elemento e insere-o na lista
    LinkedListNode* newElm = (struct LinkedListNode *) malloc(sizeof (struct LinkedListNode));
    newElm -> e = prod;
    // Se o novo elemento for maior que o atual, ele deve vir antes
    if (newElm -> e.codigo >= it -> e.codigo) {
        ant -> next = newElm;
        newElm -> next = it;
    } else {
        it -> next = newElm;
    }
    return head;
}

/**
 * Cria uma lista
 */
LinkedListNode* ls_create() {
    if (DEBUG == 1) {
        return createNewListWithValues();
    }
    return NULL;
}

/**
 * Adiciona um elemento no final de uma lista
 */
LinkedListNode* ls_append(LinkedListNode *p, Produto prod) {
    // Se for uma lista vazia, adiciona no final
    if (p == NULL) {
        return ls_preppend(p, prod);
    }
    // Itera lista até encontrar o fim
    LinkedListNode* it = p;
    while (it -> next != NULL) {
        it = it -> next;
    }
    // Cria elemento
    it -> next = (struct LinkedListNode *) malloc(sizeof (struct LinkedListNode));
    it -> next -> e = prod;
    it -> next -> next = NULL;
    return p;
}

/**
 * Adiciona um elemento no início de uma lista
 */
LinkedListNode* ls_preppend(LinkedListNode *p, Produto prod) {
    LinkedListNode* node = (struct LinkedListNode *) malloc(sizeof (struct LinkedListNode));
    node -> e = prod;
    node -> next = p;
    return node;
}

/**
 * Lê e retorna um elemento da lista pela chave
 */
LinkedListNode* ls_readKey(LinkedListNode *p, int cod) {
    LinkedListNode *i = p;
    while (i -> next != NULL) {
        if (i -> e.codigo == cod) return i;
        i = i -> next;
    }
    return NULL;
}

/**
 * Remove um elemento da lista
 */
LinkedListNode* ls_remove(LinkedListNode *head, int cod) {
    // Se o elemento não existir
    if (head == NULL || ls_readKey(head, cod) == NULL) {
        return head;
    }
    LinkedListNode *a = NULL;
    LinkedListNode *p = head;
    while (p != NULL && p->e.codigo != cod) {
        a = p;
        p = p->next;
    }
    if (a == NULL) head = p->next;
    else a->next = p->next;
    free(p -> e.descricao);
    free(p);
    // Se ainda possuir um elemento com o mesmo código deleta-o também
    if (ls_readKey(head, cod) != NULL) {
        return ls_remove(head, cod);
    }
    return head;
}

/**
 * Printa todos os elementos de uma lista
 */
void ls_printAll(LinkedListNode *p) {
    // Declara um iterador apontando pro início da lista
    LinkedListNode *it = p;
    // Printa os cabeçalhos
    printf("\nDados: ");
    printf("\n|-ROW|-Cod--|-Descricao----------------------|");
    // Percorre a lista printando
    int idx = 1;
    while (it != NULL) {
        putchar('\n');
        printf("|%4d", idx++);
        printaProduto(it -> e);
        it = it -> next;
    }
    putchar('\n');
}

/**
 * Fecha (apaga) uma lista
 */
void ls_close(LinkedListNode *head) {
    LinkedListNode *i = head;
    while (i != NULL) {
        LinkedListNode *tmp = i->next;
        free(tmp);
        i = tmp;
    }
}

/**
 * Retorna verdadeiro se uma lista está vazia
 */
int ls_isEmpty(LinkedListNode *head) {
    LinkedListNode *i = head;
    while (i->next != NULL) {
        if (i) return 0;
        i = i -> next;
    }
    return 1;
}

/**
 * Printa um produto
 */
void printaProduto(Produto e) {
    printf("| %5d| %30s |", e.codigo, e.descricao);
}

/**
 * Cria e retorna um novo produto
 */
Produto criaProduto(int cod, char valor[]) {
    Produto prr;
    prr.codigo = cod;
    prr.descricao = (char*) malloc(PROD_DESC_LEN /*strlen(valor)*/ * sizeof (char));
    strcpy(prr.descricao, valor);
    return prr;
}

/**
 * Cria uma nova lista com valores já inicializados
 */
LinkedListNode* createNewListWithValues() {
    LinkedListNode* head = NULL;
    head = ls_insert(head, criaProduto(3000, "elm3000-H"));
    head = ls_insert(head, criaProduto(4000, "elm4000"));
    head = ls_insert(head, criaProduto(5000, "elm5000-F"));
    return head;
}

/**
 * Limpa o buffer do teclado
 */
void limpaBuffer() {
    fflush(stdin);
}