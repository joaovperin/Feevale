
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import javax.swing.JOptionPane;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Gabriel
 */
public class ImplementacaoRMIExemplos extends UnicastRemoteObject implements InterfaceRMIExemplos {
    
    ImplementacaoRMIExemplos() throws RemoteException{
        super();
    }
    
    public String inverteString(String s) throws RemoteException {
        StringBuilder sb = new StringBuilder(s);
        return sb.reverse().toString();
    }

    public String concatenaString(String s) throws RemoteException {
        return s + " foi concatenado a este texto!";
    }

    public String somaNumeros(String n1, String n2) throws RemoteException {
        int v1 = Integer.parseInt(n1);
        int v2 = Integer.parseInt(n2);
        return v1 + v2 + "";
    }

    public void exibeMsg(String msg) throws RemoteException {
        JOptionPane.showMessageDialog(null, msg);
    }

    public String converteMaiusculo(String txt) throws RemoteException {
        return txt.toUpperCase();
    }    
    
}
