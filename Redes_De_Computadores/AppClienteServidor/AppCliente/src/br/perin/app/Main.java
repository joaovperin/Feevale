/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

import br.perin.app.bean.Options;
import br.perin.app.services.ArgsParser;
import br.perin.app.Sever.ServerMock;
import br.perin.app.services.PropertyLoader;

/**
 *
 * @author Joaov
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Carrega os argumentos de linha de comando
        Options opt = ArgsParser.get().parse(args);
        // Se passou a opção DEBUG, simula argumentos
        if (opt.isSet("debug")) {
            args = new String[]{"-d=C:\\Users\\0199831\\Perin\\a\\app.properties", "-r=client"};
            opt = ArgsParser.get().parse(args);
        }
        // Busca o valor do diretório passado
        String propsDir = opt.getString("d");
        PropertyLoader.get().load(propsDir);
        // Printa todas as opções e propriedades carregadas
        opt.printAll(System.out);
        System.out.println();
        PropertyLoader.get().printAll(System.out);
        // Roda a aplicação de acordo com o parâmetro recebido
        String run = opt.getString("r");
        run(run);
    }

    /**
     * Roda a aplicação de acordo com o parâmetro recebido
     *
     * @param run
     */
    private static void run(String run) {
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
