
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


public class MacPDVService extends UnicastRemoteObject implements MacPDV {
    List<Client> clients = new ArrayList<Client>();
    
    public MacPDVService() throws RemoteException{
        super();
    }
    
    @Override
    public String connectionOk() throws RemoteException {
        return "Client Connected to PDV!";
    }

    @Override
    public void registerClient(Client c) throws RemoteException {
        clients.add(c);
    }

    @Override
    public void unregisterClient(Client c) throws RemoteException {
        clients.remove(c);
    }
    
    public void delivery(){
        try {
            for (Client client : clients) {
                client.notifyDelivery();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void makeOrder(Order o){
        try {
            for (Client client : clients) {
                client.notifyOrder(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void cleanOrders() throws RemoteException {
        try {
            delivery();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
}
