/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.utils;

/**
 * System utilities
 */
public class SystemUtils {

    /**
     * Formatted (and centralized) print
     *
     * @param message
     * @param args
     */
    public static void printf(String message, Object... args) {
        System.out.printf("%s\n", String.format(message, args));
    }

    /**
     * Sleep without needing a try/catch block
     *
     * @param timeInMs
     */
    public static void sleep(int timeInMs) {
        try {
            Thread.sleep(timeInMs);
        } catch (InterruptedException ex) {
        }
    }

}
