package br.com.feevale.rmi_commons;

import java.io.Serializable;

public final class MaybeData<T> implements Serializable {
    private static final long serialVersionUID = 275961245439L;

    private final T data;

    private MaybeData(T data) {
        this.data = data;
    }

    public static <T> MaybeData<T> of(T data) {
        return new MaybeData<>(data);
    }

    public static <T> MaybeData<T> empty() {
        return new MaybeData<>(null);
    }

    public T get() {
        if (data == null) {
            throw new NullPointerException("cannot get empty data");
        }
        return data;
    }

    public boolean isPresent() {
        return data != null;
    }

    public boolean isEmpty() {
        return data == null;
    }

}
