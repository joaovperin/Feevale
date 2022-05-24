
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
public interface MacPDV extends Remote{
    public String connectionOk() throws RemoteException;
    public void registerClient(Client c) throws RemoteException;
    public void unregisterClient(Client c) throws RemoteException;
    public void cleanOrders() throws RemoteException;
}
