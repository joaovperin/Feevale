/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.utils;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Joaov
 */
public class SystemUtils {

    private static final boolean DEBUG = false;

    public static final List<String> buffer = new ArrayList<>();

    public static void printf(String message, Object... args) {
        if (DEBUG) {
            System.out.printf("%s\n", String.format(message, args));
        } else {
            buffer.add(String.format(message, args));
        }
    }

    public static void sleep(int n) {
        try {
            Thread.sleep(n);
        } catch (InterruptedException ex) {
        }
    }

}
