package br.com.feevale.rmi_commons;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface IServer extends Remote {

    public MaybeData<DataPayload> getNext() throws RemoteException;

    public void done(DataPayload payload) throws RemoteException;

}
