package br.com.feevale.rmi_server;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import br.com.feevale.rmi_server.server.Server;
import br.com.feevale.rmi_server.server.ServerData;

/**
 * Hello world!
 *
 */
public class App {

    private static final int DEF_NUMBER_OF_ARRAYS = 10;
    private static final int DEF_ARRAY_SIZE = 10_000;
    private static final int DEF_ARRAY_MAX_VALUE = 99_9999;

    private static final int DEF_PORT = 8090;
    private static final String DEF_LABEL = "srv";

    public static void main(String[] args) throws RemoteException, InterruptedException {

        final int numberOfArrays = DEF_NUMBER_OF_ARRAYS;
        final int arraySize = DEF_ARRAY_SIZE;
        final int maxValue = DEF_ARRAY_MAX_VALUE;

        // Generate ${numberOfArrays} arrays of size ${arraySize} with random values
        // between 0 and ${maxValue}
        ServerData.instance
                .generateDataPayload(numberOfArrays, arraySize, maxValue)
        // .printPayload()
        ;

        final int srvPort = DEF_PORT;
        final String srvLabel = DEF_LABEL;

        // Starts server at port ${srvPort} with label ${srvLabel}
        final Server server = new Server();
        final Registry r = LocateRegistry.createRegistry(srvPort);
        r.rebind(srvLabel, server);
        System.out.printf("*** Server '%s' started on port %d.\n", srvLabel, srvPort);

        // Prevent server from exiting
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            try {
                r.unbind(srvLabel);
                System.out.printf("*** Shutdown server '%s' of port %d! Bye.\n", srvLabel, srvPort);
            } catch (RemoteException | NotBoundException e) {
                e.printStackTrace();
            }
        }));
        Thread.currentThread().join();
    }
}
