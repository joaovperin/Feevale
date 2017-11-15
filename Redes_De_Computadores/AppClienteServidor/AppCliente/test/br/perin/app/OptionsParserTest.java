/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

import br.perin.app.bean.Opt;
import br.perin.app.bean.Options;
import br.perin.app.services.ArgsParser;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Classe OptionsParserTest
 *
 * @author Joaov
 */
public class OptionsParserTest {

    /**
     * Testa o Parse das opções
     */
    @Test
    public void testParse() {
        String[] args = new String[] { "-f=C:\\tmp\\ppt.properties", "-std=c99" };
        Options opt = ArgsParser.get().parse(args);
        int i = 0;
        for (Opt o : opt.getOptions()) {
            assertEquals(format(o.toString()), args[i++]);
        }
    }

    /**
     * Testa o parse de um par K/V
     */
    @Test
    public void testParseAlgo() {
        assertEquals(new Opt("std", "c99"), parse("-std=c99"));
        assertEquals(new Opt("f", "C:\\tmp\\ppt.properties"), parse("-f=C:\\tmp\\ppt.properties"));
    }

    /**
     * Formata a opção para as asserções dos testes
     *
     * @param str
     * @return String
     */
    private String format(String str) {
        return "-".concat(str);
    }

    /**
     * Realiza o parse de uma String em opção
     *
     * @param arg
     * @return Opt
     */
    private Opt parse(String arg) {
        return ArgsParser.get().parse(new String[] { arg }).getOptions().get(0);
    }

}
