
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


public class ClientScreen extends UnicastRemoteObject implements Client {
    public PainelCozinha panel;
    
    public ClientScreen() throws RemoteException{
        super();
    }
    
    @Override
    public void notifyOrder(Order o) throws RemoteException {
        panel.txtSaidaPedidos.append(o.toString());
        panel.txtSaidaPedidos.append("\n");
    }

    @Override
    public void notifyDelivery() throws RemoteException {
        panel.txtSaidaPedidos.setText("");
    }
    
}
