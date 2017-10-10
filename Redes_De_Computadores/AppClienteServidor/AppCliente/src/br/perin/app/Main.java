/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

import br.perin.app.bean.Options;
import br.perin.app.services.ArgsParser;
import br.perin.app.services.PropertyLoader;
import br.perin.app.services.Tester;

/**
 * Classe principal da aplicação cliente
 *
 * @author Joaov
 */
public class Main {

    /**
     * Entry point principal
     *
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        System.out.println("Cliente não implementado!! Alternando para método de testes...:");
        System.out.println();
        doTests(args);
    }

    /**
     * Entry point de testes
     *
     * @param args
     */
    private static void doTests(String[] args) {
        args = new String[] { "-d=C:\\Users\\0199831\\Perin\\a\\app.properties", "-r=client" };
        // Carrega os argumentos de linha de comando
        Options options = ArgsParser.get().parse(args);
        // Busca o valor do diretório passado
        String propsDir = options.getString("d");
        PropertyLoader.get().load(propsDir);
        // Printa todas as opções e propriedades carregadas
        options.printAll(System.out);
        System.out.println();
        PropertyLoader.get().printAll(System.out);
        // Roda a aplicação de acordo com o parâmetro recebido
        String run = options.getString("r");
        new Tester().run(run);
    }

}
