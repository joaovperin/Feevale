package br.perin.app;

import br.perin.app.bean.Options;
import br.perin.app.services.ArgsParser;
import br.perin.app.services.PropertyLoader;
import java.io.File;
import javax.script.ScriptException;

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
        // Carrega propriedades necessárias
        loadApplicationProperties(args);
        // Se deve rodar com Script
        final String ptScript = "script";
        if (PropertyLoader.get().isPresent(ptScript)) {
            startScriptApplication(getScriptFile(ptScript));
        } else {
            startHardCodedApplication();
        }
    }

    /**
     * Retorna o arquivo do Script
     *
     * @param ppt Propriedade do script
     * @return String
     */
    private static String getScriptFile(String ppt) {
        final String def = new File("script.js").
                getAbsoluteFile().toString();
        String scriptFile = PropertyLoader.get().getString(ppt, def);
        return "".equals(scriptFile.trim()) ? def : scriptFile;
    }

    /**
     * Carrega todas as opções e propriedades necessárias
     *
     * @param args
     */
    private static void loadApplicationProperties(String[] args) {
        // Se não informou parâmetros de entrada, printa a linha de ajuda
        if (args == null || args.length <= 0 || args[0] == null) {
            throw new RuntimeException(ArgsParser.get().getHelp());
        }
        // Carrega os argumentos de linha de comando
        Options options = ArgsParser.get().parse(args);
        if (!options.isPresent("d")) {
            throw new RuntimeException("É necessário informar o diretório "
                    + "do arquivo de propriedades.");
        }
        // Carrega propriedades através do diretório passado e printa opções
        PropertyLoader.get().load(options.getString("d"));
        PropertyLoader.get().printAll(System.out);
        System.out.println();
    }

    /**
     * Inicializa aplicação de Script
     */
    private static void startScriptApplication(String file) {
        try {
            ScriptApplication.get().start(file);
        } catch (ScriptException e) {
            System.out.println("Ocorreu um problema na Script Engine.");
            throw new RuntimeException(e);
        }
    }

    /**
     * Inicializa aplicação de HardCoded
     */
    private static void startHardCodedApplication() {
        HardCodedApplication.get().start();
    }

}
