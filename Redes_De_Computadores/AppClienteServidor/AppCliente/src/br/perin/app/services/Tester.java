/*
 * AppCliente
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */
package br.perin.app.services;

import br.perin.app.Client;
import br.perin.app.ProfessorClient;
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
        System.out.println();
        // Determina
        switch (run) {
            case "server":
                // Inicia o servidor de testes
                ServerMock sv = new ServerMock();
                sv.startInThread();
                break;
            case "client":
                // Cria um novo cliente, envia uma mensagem e printa o retorno
                Client cl = new ProfessorClient();
                ProfessorClient.realizaComunicacao(cl);
//                // Inicia comunicação
//                String ret = cl.sendMessage("1000000");
//                // Se comunicou com sucesso:
//                if (ret.startsWith("101")) {
//                    // Solicita mensagem do dia
//                    cl.sendMessage("2000000");
//                } else if (ret.startsWith("102")) {
//                    System.out.println("Retorno 102 -> O servidor está ocupado.");
//                } else {
//                    System.out.println("Não reconhecido: " + ret);
//                }
//                // Encerra comunicação
//                ret = cl.sendMessage("9000000");
//                // Se comunicou com sucesso:
//                if (ret.startsWith("101")) {
//                    System.out.println("Comunicação encerrada :D");
//                }
                break;
            default:
                System.out.println("Parâmetro inválido!");
                break;
        }
    }

}
