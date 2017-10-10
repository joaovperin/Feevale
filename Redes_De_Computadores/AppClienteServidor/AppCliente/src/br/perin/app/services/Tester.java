/*
 * AppCliente
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */
package br.perin.app.services;

import br.perin.app.Client;
import br.perin.app.server.ServerMock;

/**
 * Classe responsável por realizar testes
 */
public class Tester {

    /**
     * Roda a aplicação de acordo com o parâmetro recebido
     *
     * @param run
     */
    public void run(String run) {
        if (null == run) {
            System.out.println("Não determinou o que é pra rodar.");
            return;
        }
        // Determina
        switch (run) {
            case "server":
                // Inicia o servidor de testes
                ServerMock sv = new ServerMock();
                sv.startInThread();
                break;
            case "client":
                // Cria um novo cliente, envia uma mensagem e printa o retorno
                Client cl = new Client();
                System.out.println("Retorno1:" + cl.sendMessage("batata!"));
                System.out.println("Retorno2:" + cl.sendMessage("teste!"));
                break;
            default:
                System.out.println("Parâmetro inválido!");
                break;
        }
    }

}
