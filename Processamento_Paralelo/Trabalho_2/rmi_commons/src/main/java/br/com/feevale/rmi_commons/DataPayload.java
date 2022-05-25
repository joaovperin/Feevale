package br.com.feevale.rmi_commons;

import java.io.Serializable;
import java.util.List;

public class DataPayload implements Serializable {

    private static final long serialVersionUID = 161843628764L;

    final List<Integer> list;

    public DataPayload(String jsonPayload) {
        this.list = DataPayloadParser.parseList(jsonPayload).getList();
    }

    public DataPayload(List<Integer> list) {
        this.list = list;
    }

    public List<Integer> getList() {
        return list;
    }

    @Override
    public String toString() {
        return DataPayloadParser.serializeList(this);
    }

}
