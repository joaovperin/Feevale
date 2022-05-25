package br.com.feevale.rmi_server.domain;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class DataPayload implements Serializable {

    final List<Integer> list;

    public DataPayload(String jsonPayload) {
        final var arr = jsonPayload.split(",");
        this.list = Arrays.stream(arr)
                .map(String::trim)
                .filter(s -> s != null && !s.isEmpty())
                .map(Integer::parseInt)
                .collect(Collectors.toList());
    }

    public DataPayload(List<Integer> list) {
        this.list = list;
    }

    List<Integer> getList() {
        return list;
    }

    @Override
    public String toString() {
        return list.stream().map(Object::toString).collect(Collectors.joining(","));
    }

}
