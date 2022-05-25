package br.com.feevale.rmi_server.server;

import java.util.List;
import java.util.Queue;
import java.util.Random;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import br.com.feevale.rmi_commons.DataPayload;

public class ServerData {

    public static final ServerData instance = new ServerData();

    private ServerData() {
    }

    final ThreadPoolExecutor threadPool = new ThreadPoolExecutor(
            Runtime.getRuntime().availableProcessors(),
            Runtime.getRuntime().availableProcessors(),
            0L,
            java.util.concurrent.TimeUnit.MILLISECONDS,
            new LinkedBlockingQueue<>());

    final Queue<DataPayload> queue = new LinkedBlockingQueue<DataPayload>(128);

    public ServerData generateDataPayload(
            final int numberOfArrays,
            final int arraySize,
            final int maxValue) {

        if (queue.isEmpty()) {
            final var rng = new Random();
            IntStream.range(0, numberOfArrays).forEach(i -> {
                List<Integer> list = IntStream.range(0, arraySize)
                        .mapToObj(j -> rng.nextInt(maxValue))
                        .collect(Collectors.toList());
                queue.add(new DataPayload(list));
            });
        }

        return this;
    }

    public ServerData printPayload() {

        System.out.println("*** Payload: ***");
        for (var payload : queue) {
            System.out.println(payload);
            System.out.println();
        }

        return this;
    }

}
