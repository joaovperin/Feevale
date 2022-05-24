
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
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
public class BatePapoClient {
    

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        try {
            BufferedReader keyIn = new BufferedReader(
                    new InputStreamReader(System.in));

            Socket s = new Socket("localhost", 4478);
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(s.getInputStream()));
            PrintWriter out = new PrintWriter(s.getOutputStream());

            String mensagem = "";

            while(true) {
                mensagem = keyIn.readLine();
                out.println(mensagem);
                out.flush();            

                mensagem = in.readLine();

                System.out.println(mensagem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
