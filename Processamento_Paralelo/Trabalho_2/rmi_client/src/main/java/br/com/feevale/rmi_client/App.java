package br.com.feevale.rmi_client;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.List;

import br.com.feevale.rmi_commons.DataPayload;
import br.com.feevale.rmi_commons.IServer;
import br.com.feevale.rmi_commons.MaybeData;

/**
 * Hello world!
 *
 */
public class App {

    private static final String HOST = "localhost";
    private static final int PORT = 8090;
    private static final String SERVICE_NAME = "srv";

    public static void main(String[] args)
            throws RemoteException, NotBoundException, MalformedURLException, InterruptedException {
        final var serverUri = String.format(
                "rmi://%s:%d/%s",
                HOST, PORT, SERVICE_NAME);
        IServer rmiServer = (IServer) Naming.lookup(serverUri);
        System.out.printf("*** Client connected to '%s'.\n", serverUri);

        MaybeData<DataPayload> nextPayload = MaybeData.empty();
        do {
            nextPayload = rmiServer.getNext();

            if (nextPayload.isPresent()) {
                System.out.printf("*** Client got data! Sorting...\n");

                final var list = nextPayload.get().getList();
                final var sortedList = bubbleSort(list);
                rmiServer.done(new DataPayload(sortedList));

                System.out.printf("*** Client finished sorting data.\n");
            }

            Thread.sleep(10);
        } while (nextPayload.isPresent());

    }

    public static List<Integer> bubbleSort(List<Integer> input) {
        int n = input.size();
        for (int i = 0; i < n - 1; i++)
            for (int j = 0; j < n - i - 1; j++)
                if (input.get(j) > input.get(j + 1)) {
                    // swap arr[j+1] and arr[i]
                    int temp = input.get(j);
                    input.set(j, input.get(j + 1));
                    input.set(j + 1, temp);
                }
        return input;
    }
}
