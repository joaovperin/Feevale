
import java.rmi.Remote;
import java.rmi.RemoteException;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author gabriel
 */
public interface Client extends Remote{
    public void notifyOrder(Order p) throws RemoteException;
    public void notifyDelivery() throws RemoteException;
}
