package br.perin.app;

import br.perin.app.inject.Client;

/**
 * Classe que representa um cliente no formato do professor
 *
 * @author Joaov
 */
public class HardCodedApplication {

    /** Instância do Singleton */
    private static HardCodedApplication instance;

    /**
     * Construtor privado
     */
    private HardCodedApplication() {
        // 1-3 = Código da requisição/resposta
        // 4-7 = Tamanho da mensagem retornada
        // 8-2000 = Mensagem
    }

    /**
     * Realiza a comunicação com o servidor
     */
    public void start() {
        // Inicia comunicação
        Client cl = new Client();
        System.out.println("Iniciando comunicação...");
        String ret = cl.sendMessage("1000000");
        // Protocolo incorreto.
        if (ret.startsWith("999")) {
            System.out.println("O servidor informou que o protocolo está "
                    + "incorreto!");
            return;
        }
        // Se comunicou com sucesso:
        if (ret.startsWith("101")) {
            System.out.println("Servidor pronto para comunicação!");
            // Solicita mensagem do dia
            ret = cl.sendMessage("2000000");
            if (ret.startsWith("201")) {
                // Obtém o tamanho da mensagem
                int tam = Integer.valueOf(ret.substring(3, 7));
                System.out.println("Mensagem do dia: "
                        + ret.substring(7, 7 + tam));
            } else {
                System.out.println("Falha na comunicação!");
            }
        } else if (ret.startsWith("102")) {
            // Se estiver ocupado, não é necessário encerrar comunicação
            System.out.println("O servidor está ocupado."
                    + " Tente novamente mais tarde!");
            return;
        } else {
            System.out.println("Retorno não reconhecido: " + ret);
        }
        System.out.println("Encerrando comunicação...");
        // Encerra comunicação
        ret = cl.sendMessage("9000000");
        // Se comunicou com sucesso:
        if (ret.startsWith("901")) {
            System.out.println("Comunicação encerrada com sucesso :D");
        } else {
            System.out.println("Falha ao encerrar comunicação. "
                    + "Retorno:".concat(ret));
        }
    }

    /**
     * Retorna a instância do Singleton
     *
     * @return HardCodedApplication
     */
    public static HardCodedApplication get() {
        if (instance == null) {
            instantiate();
        }
        return instance;
    }

    /**
     * Instancia o Singleton
     */
    private static synchronized void instantiate() {
        if (instance == null) {
            instance = new HardCodedApplication();
        }
    }
}
