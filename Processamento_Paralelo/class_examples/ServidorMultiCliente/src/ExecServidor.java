
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author gabriel
 */
public class ExecServidor {
    public static List<ClienteConectado> clientes = new ArrayList<>();
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        ExecServidor es = new ExecServidor();
        es.aguardaCliente();
    }
    
    public void aguardaCliente(){
        ClienteConectado smc;
        Socket s;
        try {
            ServerSocket ss = new ServerSocket(4478);
            
            while(true){
                s = ss.accept();
                smc = new ClienteConectado(s);
                smc.configurarFluxos();
                clientes.add(smc);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
