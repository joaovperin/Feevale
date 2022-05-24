
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
public class ClienteMultiChat extends Thread{
    Socket s;
    BufferedReader in;
    BufferedReader teclado;
    PrintWriter out;
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        ClienteMultiChat cmc = new ClienteMultiChat();                
        cmc.conectar("www.feevale.br", 80);
        cmc.start();
        
        while(true)
            cmc.enviarMsg();
    }
    
    public void conectar(String destino, Integer porta){
        try {
            s = new Socket(destino, porta);
            in = new BufferedReader(
                    new InputStreamReader(s.getInputStream()));
            out = new PrintWriter(s.getOutputStream());
            teclado = new BufferedReader(
                    new InputStreamReader(System.in));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void enviarMsg(){
        try {
            out.println(teclado.readLine());
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }        
    }
    
    public void receberMsg(){
        String msg = "";
        try {
            msg = in.readLine();
            System.out.println(msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        while(true){
            receberMsg();
        }
    }
    
    
}
