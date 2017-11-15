package br.perin.app.inject;

import javax.swing.JOptionPane;

/**
 * Classe responsável por funções úteis/comuns à aplicação
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
        JOptionPane.showMessageDialog(null, message, title,
                JOptionPane.WARNING_MESSAGE);
    }

}
