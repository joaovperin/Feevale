/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

import br.perin.app.services.PropertyLoader;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;

/**
 * Classe Client
 *
 * @author Joaov
 */
public class Client {

    /** Socket da conexão com o servidor */
    private Socket socket;
    //
    //
    // 1-3 = cod
    // 4-7 = tamanho
    // 8-2000 = msg
    //
    //
    /**
     * Envia uma mensagem para o servidor
     *
     * @param msg Mensagem a enviar
     * @return String Resposta
     */
    public String sendMessage(String msg) {
        String retorno;
        try {
            connect();
            retorno = send(msg);
            closeConn();
        } catch (IOException e) {
            retorno = "NOTOK";
        }
        return retorno;
    }

    /**
     * Realiza a conexão
     */
    private void connect() throws IOException {
        PropertyLoader pt = PropertyLoader.get();
        connect(pt.getString("host", "localhost"), pt.getInt("port", 6969));
    }

    /**
     * Realiza a conexão através dos parâmetros
     *
     * @param address
     * @param port
     */
    private void connect(String address, int port) throws IOException {
        try {
            InetAddress.getByName(address);
            socket = new Socket(address, port);
        } catch (UnknownHostException ex) {
            throw new IOException("Host não encontrado", ex);
        }
    }

    /**
     * Realiza o envio da mensagem ao servidor
     *
     * @param msg
     * @return String
     */
    private String send(String msg) throws IOException {
        // Se não estiver conectado
        if (socket == null || !socket.isConnected()) {
            throw new IOException("Não vai rolar.");
        }
        // Envia a mensagem para o servidor
        try (BufferedWriter out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()))) {
            out.write(msg);
            out.flush();
            socket.shutdownOutput();
            // Recebe a resposta do servidor
            try (BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()))) {
                return in.readLine();
            }
        }
    }

    /**
     * Fecha a conexão com o servidor
     */
    private void closeConn() throws IOException {
        socket.close();
        if (!socket.isClosed()) {
            throw new IOException("Falha ao fechar a conexão");
        }
        socket = null;
    }

}
