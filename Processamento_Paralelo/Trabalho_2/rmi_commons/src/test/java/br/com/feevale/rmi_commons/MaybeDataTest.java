package br.com.feevale.rmi_commons;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

public class MaybeDataTest {

    @Test
    void testInstantiate() {
        final var nullData = MaybeData.of(null);
        assertFalse(nullData.isPresent());
        assertTrue(nullData.isEmpty());
        assertThrows(NullPointerException.class, () -> nullData.get());

        final var objData = MaybeData.of("hello");
        assertFalse(objData.isEmpty());
        assertTrue(objData.isPresent());
        assertEquals("hello", objData.get());

        final var emptyData = MaybeData.empty();
        assertFalse(emptyData.isPresent());
        assertTrue(emptyData.isEmpty());
        assertThrows(NullPointerException.class, () -> emptyData.get());
    }

}
