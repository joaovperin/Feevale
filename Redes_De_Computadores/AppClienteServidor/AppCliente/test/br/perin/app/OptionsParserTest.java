/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

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

    @Test
    public void testParse() {
        String[] args = new String[]{"-f=C:\\tmp\\ppt.properties", "-std=c99"};
        Options opt = ArgsParser.get().parse(args);
        int i = 0;
        for (Opt o : opt.getOptions()) {
            assertEquals(format(o.toString()), args[i++]);
        }
    }

    @Test
    public void testParseAlgo() {
        assertEquals(new Opt("std", "c99"), parse("-std=c99"));
        assertEquals(new Opt("f", "C:\\tmp\\ppt.properties"), parse("-f=C:\\tmp\\ppt.properties"));
    }

    private String format(String x) {
        return "-".concat(x);
    }

    private Opt parse(String arg) {
        return ArgsParser.get().parse(new String[]{arg}).getOptions().get(0);
    }

}
