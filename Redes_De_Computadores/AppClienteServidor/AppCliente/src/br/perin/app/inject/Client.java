/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app.inject;

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
 * Classe que representa um Client, responsável por se comunicar com um servidor
 *
 * O pacote inject agrupa classes injetadas no script.
 *
 * @author Joaov
 */
public class Client {

    /** Timeout padrão */
    private static final int DEF_SO_TIMEOUT = 2000;

    /** Socket da conexão com o servidor */
    private Socket socket;

    /**
     * Envia uma mensagem para o servidor
     *
     * @param msg Mensagem a enviar
     * @return String Resposta
     */
    public final String sendMessage(String msg) {
        String retorno;
        try {
            connect();
            retorno = send(transform(msg));
            closeConn();
        } catch (IOException e) {
            String m = "Falha na comunicação. Motivo: ".concat(e.getMessage());
            retorno = String.format("000%d%s", m.length(), m);
        }
        return retorno;
    }

    /**
     * Realiza a conexão
     *
     * @throws java.io.IOException
     */
    protected final void connect() throws IOException {
        PropertyLoader pt = PropertyLoader.get();
        connect(pt.getString("host", "localhost"),
                pt.getInt("port", 6969),
                pt.getInt("timeout", DEF_SO_TIMEOUT));
    }

    /**
     * Realiza a conexão através dos parâmetros
     *
     * @param address
     * @param port
     * @param timeout
     * @throws java.io.IOException
     */
    protected final void connect(String address, int port, int timeout) throws IOException {
        try {
            InetAddress.getByName(address);
            socket = new Socket(address, port);
            socket.setSoTimeout(timeout);
        } catch (UnknownHostException ex) {
            throw new IOException("Host não encontrado", ex);
        }
    }

    /**
     * Realiza o envio da mensagem ao servidor
     *
     * @param msg
     * @return String
     * @throws java.io.IOException
     */
    protected final String send(String msg) throws IOException {
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

    /**
     * Transforma a mensagem antes de enviar
     *
     * @param crudeMsg
     * @return String
     */
    protected String transform(String crudeMsg) {
        return crudeMsg;
    }

}
