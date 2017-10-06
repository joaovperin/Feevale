/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app.Sever;

import br.perin.app.services.PropertyLoader;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Classe ServerMock
 *
 * @author Joaov
 */
public class ServerMock {

    /** Porta */
    private int serverPort;

    /** Socket do Servidor */
    private ServerSocket socket;

    /**
     * Inicia o servidor em uma Thread
     */
    public void startInThread() {
        new Thread(() -> this.start()).start();
    }

    /**
     * Inicia o servidor
     */
    public void start() {
        try {
            config();
            socket = new ServerSocket(serverPort);
            System.out.println("Servidor iniciado com sucesso na porta " + serverPort);
            while (true) {
                await();
            }
        } catch (IOException ex) {
            System.out.println("falha: " + ex);
        }
    }

    /**
     * Configura o servidor
     */
    private void config() {
        System.out.println("Configurando o server...");
        PropertyLoader pt = PropertyLoader.get();
        serverPort = pt.getInt("port", 6969);
    }

    /**
     * Aguarda o recebimento de uma conexão
     */
    private void await() {
        // Aguarda o estabelecimento de uma conexão
        try (Socket conn = socket.accept()) {
            // Cria o buffer de entrada e lê a mensagem recebida
            BufferedReader from = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            System.out.println("Msg recebida[Sv]: " + from.readLine());
            // Cria o buffer de saída e devolve um status de OK
            try (DataOutputStream to = new DataOutputStream(conn.getOutputStream())) {
                to.write("OK".getBytes());
                to.flush();
            }
        } catch (IOException ex) {
            System.out.println("falha: " + ex);
        }
    }

}
