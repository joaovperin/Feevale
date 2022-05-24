
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author gabriel
 */
public class ServerMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        try {
            ServerSocket ss = new ServerSocket(8084);
            String sitePath = "/home/gabriel/tmp/www";
            while (true) {
                
                Socket s = ss.accept();

                BufferedReader in = new BufferedReader(
                        new InputStreamReader(s.getInputStream()));
                OutputStream out = s.getOutputStream();

                String primeiraLinha = in.readLine();
                String l = "";
                while ((l = in.readLine()).length() > 0);
                
                String nomeConteudo = primeiraLinha.split(" ")[1];
                
                File contentFile = new File(sitePath + nomeConteudo);
                byte fileBytes[] = new byte[(int)contentFile.length()];
                FileInputStream fis = new FileInputStream(contentFile);
                fis.read(fileBytes);
                
                System.out.println(nomeConteudo);

                
                
                String header = "HTTP/1.1 200 OK\n"
                        + "Server: Sist.Dist. Server 1.0\n"
                        + "Connection: close\n"
                        + "Content-Length: "+ contentFile.length() +"\n\n";
                

                out.write(header.getBytes());
                out.write(fileBytes);
                out.flush();
                out.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
