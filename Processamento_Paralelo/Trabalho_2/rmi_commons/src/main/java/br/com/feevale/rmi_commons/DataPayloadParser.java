package br.com.feevale.rmi_commons;

import java.util.Arrays;
import java.util.stream.Collectors;

class DataPayloadParser {

    private DataPayloadParser() {
        throw new RuntimeException("Utility class, not to be instantiated");
    }

    static DataPayload parseList(String jsonPayload) {
        final var arr = jsonPayload.split(",");
        final var list = Arrays.stream(arr)
                .map(String::trim)
                .filter(s -> s != null && !s.isEmpty())
                .map(Integer::parseInt)
                .collect(Collectors.toList());
        return new DataPayload(list);
    }

    static String serializeList(DataPayload payload) {
        return payload.getList().stream()
                .map(Object::toString)
                .collect(Collectors.joining(","));
    }

}
