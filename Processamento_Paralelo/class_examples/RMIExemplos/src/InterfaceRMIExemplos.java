
import java.rmi.Remote;
import java.rmi.RemoteException;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Gabriel
 */
public interface InterfaceRMIExemplos extends Remote{
    public String inverteString(String s) throws RemoteException;
    public String concatenaString(String s) throws RemoteException;
    public String somaNumeros(String n1, String n2) throws RemoteException;
    public void exibeMsg(String msg) throws RemoteException;
    public String converteMaiusculo(String txt) throws RemoteException;
}
