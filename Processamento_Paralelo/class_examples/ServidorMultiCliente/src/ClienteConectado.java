
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
public class ClienteConectado implements Runnable{
    Thread t;
    Socket s;
    BufferedReader in;
    PrintWriter out;

    public ClienteConectado(Socket s) {
        this.s = s;
    }
    
    public void configurarFluxos(){
        try {
            in = new BufferedReader(new InputStreamReader(s.getInputStream()));
            out = new PrintWriter(s.getOutputStream());
            t = new Thread(this);
            t.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void aguardaMensagens(){
        String msg = "";
        try {
            while((msg = in.readLine()) != null){
                for(ClienteConectado cc:ExecServidor.clientes){
                    cc.enviarMensagem(msg);
                }
            }
            in.close();
            out.close();
            s.close();
            ExecServidor.clientes.remove(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void enviarMensagem(String txt){
        out.println(txt);
        out.flush();
    }

    @Override
    public void run() {
        aguardaMensagens();
    }
    
    
}
