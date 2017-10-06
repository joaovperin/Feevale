/*
 * AppCliente
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */
package br.perin.app.services;

import br.perin.app.bean.Message;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 *
 * @author Perin
 */
public class MessageParserTest {

    /**
     * Teste de parse de uma mensagem qualquer
     */
    @Test
    public void testMessageQualquer() {
        Message parse = new MessageParser().parse("111005abcde");
        assertEquals(111, parse.getCod());
        assertEquals(5, parse.getLen());
        assertEquals("abcde", parse.getMsg());
    }

    /**
     * Teste de parse de uma mensagem qualquer
     */
    @Test(expected = RuntimeException.class)
    public void testMessageInvalida() {
        new MessageParser().parse("1x1005abcde");
        new MessageParser().parse("1110xabcde");
        new MessageParser().parse("1105cxcxcxcx");
        new MessageParser().parse("a001005abcde");
    }

}
