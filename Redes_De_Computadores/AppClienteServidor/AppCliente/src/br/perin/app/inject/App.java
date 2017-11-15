/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app.inject;

import javax.swing.JOptionPane;

/**
 * Classe responsável por funções úteis/comuns à aplicação
 *
 * O pacote inject agrupa classes injetadas no script.
 *
 * @author Joaov
 */
public class App {

    /**
     * Printa um texto na tela
     *
     * @param text
     */
    public void print(String text) {
        System.out.println(text);
    }

    /**
     * Printa um texto na tela
     *
     * @param message
     */
    public void alert(String message) {
        alert(message, "Atenção!");
    }

    /**
     * Printa um texto na tela
     *
     * @param message
     * @param title
     */
    public void alert(String message, String title) {
        JOptionPane.showMessageDialog(null, message, title, JOptionPane.WARNING_MESSAGE);
    }

}
