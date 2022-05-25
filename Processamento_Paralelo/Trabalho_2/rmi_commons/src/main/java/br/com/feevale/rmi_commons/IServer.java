package br.com.feevale.rmi_commons;

import java.io.Serializable;
import java.rmi.RemoteException;

public interface IServer extends Serializable {

    static final long serialVersionUID = 193873226431L;

    public DataPayload getNext() throws RemoteException;

    public void done(DataPayload payload) throws RemoteException;

}
