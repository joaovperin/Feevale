/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app.bean;

import br.perin.app.Opt;
import java.io.PrintStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Classe Options
 *
 * @author Joaov
 */
public class Options {

    /**
     * Lista de opções carregadas
     */
    private final List<Opt> options;
    /**
     * Tamanho do buffer
     */
    private static final int BUFF_SIZE = 512;

    /**
     * Construtor padrão
     */
    public Options() {
        this.options = new ArrayList<>();
    }

    /**
     * Adiciona uma opção na lista
     *
     * @param option
     */
    public void put(Opt option) {
        if (options.contains(option)) {
            throw new RuntimeException("Opção já existe");
        }
        options.add(option);
    }

    /**
     * Retorna o valor de uma opção carregada buscando pelo alias
     *
     * @param alias
     * @return String
     */
    public String getString(String alias) {
        return getProperty(alias, true);
    }

    /**
     * Retorna o valor de uma opção carregada buscando pelo alias
     *
     * @param alias
     * @return String
     */
    public boolean isSet(String alias) {
        String r = getProperty(alias, false);
        return !r.trim().isEmpty()
                && (Boolean.parseBoolean(r) || r.equalsIgnoreCase(BigDecimal.ONE.toString()));
    }

    /**
     * Retorna uma cópia da lista de opções
     *
     * @return List
     */
    public List<Opt> getOptions() {
        return Collections.synchronizedList(options);
    }

    /**
     * Printa todas as opções carregadas
     *
     * @param output
     */
    public void printAll(PrintStream output) {
        output.println("Opções de linha de comando:");
        options.stream().forEach((e) -> {
            output.println(e.toString());
        });
    }

    /**
     * Retorna a representação as opções no formato String
     *
     * @return String
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(BUFF_SIZE);
        options.stream().forEach((e) -> {
            sb.append('\n').append(e.toString());
        });
        return sb.toString();
    }

    /**
     * Retorna o valor de uma opção carregada buscando pelo alias
     *
     * @param alias
     * @return String
     */
    private String getProperty(String alias, boolean throwException) {
        try {
            return options.stream().filter((o) -> o.getAlias().equals(alias)).
                    findFirst().get().getValue();
        } catch (Exception e) {
            if (throwException) {
                throw new RuntimeException("Parâmetro não encontrado: ".concat(alias));
            }
        }
        // Retorna uma String vazia para evitar problemas 
        return new String();
    }

}
