package br.com.feevale.rmi_server;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Hello world!
 *
 */
public class App {

    private static final int DEF_NUMBER_OF_ARRAYS = 5; // 10
    private static final int DEF_ARRAY_SIZE = 20; // // 10000
    private static final int DEF_ARRAY_MAX_VALUE = 999; // unlimited

    public static void main(String[] args) {
        System.out.println("Hello World!");

        final int numberOfArrays = DEF_NUMBER_OF_ARRAYS;
        final int arraySize = DEF_ARRAY_SIZE;
        final int maxValue = DEF_ARRAY_MAX_VALUE;

        final List<List<Integer>> allPayloads = new ArrayList<>(numberOfArrays);

        final var rng = new Random();
        IntStream.range(0, numberOfArrays).forEach(i -> {
            allPayloads.add(IntStream.range(0, arraySize)
                    .mapToObj(j -> rng.nextInt(maxValue))
                    .collect(Collectors.toList()));
        });

        System.out.println("*** Payloads:");
        for (var payload : allPayloads) {
            System.out.println(payload);
            System.out.println();
        }

    }
}
