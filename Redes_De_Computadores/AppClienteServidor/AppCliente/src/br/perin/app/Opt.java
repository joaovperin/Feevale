/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

import java.util.Objects;

/**
 * Classe Opt
 *
 * @author Joaov
 */
public class Opt {

    /** Tamanho do buffer do SB */
    private static final int BUFF_SIZE = 128;

    /** Alias da opção */
    private final String alias;
    /** Valor da opção */
    private final String value;

    /**
     * Construtor padrão
     *
     * @param alias
     * @param value
     */
    public Opt(String alias, String value) {
        this.alias = alias;
        this.value = value;
    }

    /**
     * Retorna o alias da opção
     *
     * @return String
     */
    public String getAlias() {
        return alias;
    }

    /**
     * Retorna o valor da opção
     *
     * @return String
     */
    public String getValue() {
        return value;
    }

    /**
     * Retorna a representação do objeto no formato String
     *
     * @return String
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(BUFF_SIZE);
        sb.append(getAlias()).append("=").append(getValue());
        return sb.toString();
    }

    /**
     * Comparação igualitária do objeto
     *
     * @return boolean
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Opt other = (Opt) obj;
        if (!Objects.equals(this.alias, other.alias)) {
            return false;
        }
        if (!Objects.equals(this.value, other.value)) {
            return false;
        }
        return true;
    }

    /**
     * Gera e retorna um hasCode do objeto
     *
     * @return int
     */
    @Override
    public int hashCode() {
        int hash = 5;
        hash = 23 * hash + Objects.hashCode(this.alias);
        hash = 23 * hash + Objects.hashCode(this.value);
        return hash;
    }

}
