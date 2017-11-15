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

    /**
     * Printa um texto na tela
     *
     * @param message
     */
    public void info(String message) {
        info(message, "Informação");
    }

    /**
     * Printa um texto na tela
     *
     * @param message
     * @param title
     */
    public void info(String message, String title) {
        JOptionPane.showMessageDialog(null, message, title,
                JOptionPane.INFORMATION_MESSAGE);
    }

    /**
     * Exibe uma box de mensagem
     *
     * @param message
     * @param title
     * @param icon
     */
    public void alert(String message, String title, String icon) {
        dialog(message, title, getIcon(icon));
    }

    /**
     * Exibe uma caixa de diálogo
     *
     * @param message
     * @param title
     * @param icon
     */
    public void dialog(String message, String title, int icon) {
        // Exibe a dialog com o ícone identificado
        JOptionPane.showMessageDialog(null, message, title, icon);
    }

    /**
     * Exibe uma caixa de diálogo de sim/não e retorna verdadeiro se clicou no
     * Sim.
     *
     * @param message
     * @return boolean
     */
    public boolean confirm(String message) {
        return confirm(message, "Questionamento");
    }

    /**
     * Exibe uma caixa de diálogo de sim/não e retorna verdadeiro se clicou no
     * Sim.
     *
     * @param message
     * @param title
     * @return boolean
     */
    public boolean confirm(String message, String title) {
        return JOptionPane.showConfirmDialog(null, message, title,
                JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE)
                == 0;
    }

    /**
     * Identifica o ícone pelo nome
     *
     * @param icon
     * @return int
     */
    private int getIcon(String icon) {
        if (icon != null) {
            if ("WARNING".equalsIgnoreCase(icon)
                    || "WARN".equalsIgnoreCase(icon)) {
                return JOptionPane.WARNING_MESSAGE;
            } else if ("INFO".equalsIgnoreCase(icon)
                    || "INFORMATION".equalsIgnoreCase(icon)) {
                return JOptionPane.INFORMATION_MESSAGE;
            } else if ("QUESTION".equalsIgnoreCase(icon)) {
                return JOptionPane.QUESTION_MESSAGE;
            } else if ("ERROR".equalsIgnoreCase(icon)) {
                return JOptionPane.ERROR_MESSAGE;
            }
        }
        return JOptionPane.INFORMATION_MESSAGE;
    }

}
