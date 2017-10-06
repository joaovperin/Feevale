/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app.services;

import br.perin.app.Opt;
import br.perin.app.bean.Options;
import java.util.regex.Pattern;

/**
 * Classe ArgsParser
 *
 * @author Joaov
 */
public class ArgsParser {

    /** Instância do Singleton */
    public static ArgsParser instance;

    /**
     * Realiza o parse de um array de argumentos de linha de comando
     *
     * @param cmdLineArgs
     * @return Options
     */
    public Options parse(String[] cmdLineArgs) {
        Options opt = new Options();
        for (String a : cmdLineArgs) {
            opt.put(parseOpt(a));
        }
        return opt;
    }

    /**
     * Realiza o parse de um argumento de linha de comando
     *
     * @param args
     * @return Opt
     */
    private Opt parseOpt(String args) {
        assertValidArgs(args);
        int idxEqual = args.indexOf('=');
        if (idxEqual == -1) {
            return parseBooleanOpt(args);
        }
        String key = getKey(args, idxEqual);
        String value = args.substring(idxEqual + 1, args.length());
        return new Opt(key, value);
    }

    /**
     * Realiza o parse de um argumento de linha de comando
     *
     * @param key
     * @return Opt
     */
    private Opt parseBooleanOpt(String key) {
        return new Opt(getKey(key, key.length()), String.valueOf(Boolean.TRUE.booleanValue()));
    }

    /**
     * Retorna a instância do Singleton
     *
     * @return ArgsParser
     */
    public static ArgsParser get() {
        if (instance == null) {
            instantiate();
        }
        return instance;
    }

    /**
     * Instancia o Singleton
     */
    private static synchronized void instantiate() {
        if (instance == null) {
            instance = new ArgsParser();
        }
    }

    /**
     * Retorna a chave da opção
     *
     * @param arg
     * @param keyLen
     * @return String
     */
    private String getKey(String arg, int keyLen) {
        return arg.substring(1, keyLen);
    }

    /**
     * Garante que todos os argumentos são válidos
     */
    private void assertValidArgs(String args) {
        assertOptNotNullNotEmpty(args);
        assertOptHasMinimumSize(args);
        assertOptStartsWithTrace(args);
        assertOptStartsWithLetter(args);
    }

    /**
     * Garante que a opção é não nula e possui valor definido
     *
     * @param args
     */
    private void assertOptNotNullNotEmpty(String args) {
        if (args == null || args.trim().isEmpty()) {
            throw new RuntimeException("Opção nula ou sem valor definido: ".concat(args));
        }
    }

    /**
     * Garante que a opção possui um tamanho mínimo
     *
     * @param args
     */
    private void assertOptHasMinimumSize(String args) {
        final int minLen = 4;
        if (args.length() < minLen) {
            throw new RuntimeException(String.format(
                    "Opção deve possuir no mínimo %1d carácteres: %s", minLen, args
            ));
        }
    }

    /**
     * Garante que a opção inicia com uma letra após o caracter delimitador
     *
     * @param args
     */
    private void assertOptStartsWithLetter(String args) {
        if (!Pattern.compile("^-\\w").matcher(args).find()) {
            throw new RuntimeException("Nome da opção deve iniciar com uma letra: ".concat(args));
        }
    }

    /**
     * Garante que a opção inicia com um traço
     */
    private void assertOptStartsWithTrace(String args) {
        if (!args.startsWith("-")) {
            throw new RuntimeException("Opção deve iniciar com um traço '-': ".concat(args));
        }
    }

}
