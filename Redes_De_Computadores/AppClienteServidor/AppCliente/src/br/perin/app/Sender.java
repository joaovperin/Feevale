/*
 * AppCliente
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */
package br.perin.app;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.Socket;

/**
 * Descrição da classe.
 */
public class Sender {

    /** Porta */
    private static final int PORT = 6969;

    public static void main(String[] args) throws Exception {
        new Sender().cliente();
    }

    private void cliente() {
        Socket socket = null;
        try {
//            String ip = "201.87.177.161";
//            String ip = "192.168.0.235";
            String ip = "localhost";
            InetAddress addr = InetAddress.getByName(ip);

            socket = new Socket(ip, PORT);

            // envia pro servidor a string
            BufferedWriter out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            out.write("qualquer string");
            out.flush();
            socket.shutdownOutput();

            // recebe do servidor
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String ret = in.readLine();
            System.out.println("retorno do servico :" + ret);

            in.close();
            out.close();
            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
