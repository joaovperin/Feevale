/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

/**
 * Classe que representa um cliente no formato do professor
 *
 * @author Joaov
 */
public class ProfessorClient extends Client {

    /**
     * Realiza a comunicação com o servidor
     *
     * @param cl
     */
    public static void realizaComunicacao(Client cl) {
        // Inicia comunicação
        String ret = cl.sendMessage("1000000");
        // Se comunicou com sucesso:
        if (ret.startsWith("101")) {
            // Solicita mensagem do dia
            System.out.println(cl.sendMessage("2000000"));
        } else if (ret.startsWith("102")) {
            System.out.println("Retorno 102 -> O servidor está ocupado.");
        } else {
            System.out.println("Não reconhecido: " + ret);
        }
        // Encerra comunicação
        ret = cl.sendMessage("9000000");
        // Se comunicou com sucesso:
        if (ret.startsWith("101")) {
            System.out.println("Comunicação encerrada :D");
        }
    }

    //
    //
    // 1-3 = cod
    // 4-7 = tamanho
    // 8-2000 = msg
    //
    //
}
