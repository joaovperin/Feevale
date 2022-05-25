package br.com.feevale.rmi_client.domain;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.ArrayList;
import java.util.Arrays;

import org.junit.jupiter.api.Test;

class DataPayloadTest {

    @Test
    void testSerialize() {
        // Empty list
        var dt1 = new DataPayload(new ArrayList<>());
        assertEquals("", dt1.toString());

        // List with single element
        var dt2 = new DataPayload(Arrays.asList(0));
        assertEquals("0", dt2.toString());

        // List with elements
        var dt3 = new DataPayload(Arrays.asList(1, 2, 3, 4, 5));
        assertEquals("1,2,3,4,5", dt3.toString());
    }

    @Test
    void testDeserialize() {
        // Empty list
        var dt1 = new DataPayload("");
        assertEquals(0, dt1.getList().size());

        // List with single element
        var dt2 = new DataPayload("0");
        assertEquals(1, dt2.getList().size());
        assertEquals(0, dt2.getList().get(0).intValue());

        // // List with elements
        var dt3 = new DataPayload("1,13, 294");
        final var ls3 = dt3.getList();
        assertEquals(3, ls3.size());
        assertEquals(1, ls3.get(0).intValue());
        assertEquals(13, ls3.get(1).intValue());
        assertEquals(294, ls3.get(2).intValue());
    }

}
