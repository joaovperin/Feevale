package br.com.feevale.rmi_server.server;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

import br.com.feevale.rmi_commons.DataPayload;
import br.com.feevale.rmi_commons.IServer;
import br.com.feevale.rmi_commons.MaybeData;

public class Server extends UnicastRemoteObject implements IServer {

    public Server() throws RemoteException {
        super();
    }

    @Override
    public MaybeData<DataPayload> getNext() throws RemoteException {
        final var queue = ServerData.instance.queue;
        return queue.isEmpty()
                ? MaybeData.empty()
                : MaybeData.of(queue.poll());
    }

    @Override
    public void done(DataPayload payload) throws RemoteException {
        final var threadPool = ServerData.instance.threadPool;
        threadPool.submit(() -> {
            System.out.println("*** Worker DONE processing payload: ");
            System.out.println(payload);
            System.out.println();
        });
    }

}
