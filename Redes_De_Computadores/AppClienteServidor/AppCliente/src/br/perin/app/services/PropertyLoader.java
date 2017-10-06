/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app.services;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.util.Properties;

/**
 * Classe PropertyLoader
 *
 * @author Joaov
 */
public class PropertyLoader {

    /**
     * Instância Singleton
     */
    private static PropertyLoader instance;

    /**
     * Cache de propriedades
     */
    private final Properties properties;

    /**
     * Construtor privado do Singleton
     */
    private PropertyLoader() {
        this.properties = new Properties();
    }

    /**
     * Carrega as propriedades dado um diretório
     *
     * @param dir
     */
    public void load(String dir) {
        try {
            InputStream f = new FileInputStream(dir);
            properties.load(f);
            if (properties.isEmpty()) {
                System.out.println(getNoPropertyLoadedMessage("Arquivo de propriedades vazio."));
            }
        } catch (FileNotFoundException ex) {
            System.out.println(getNoPropertyLoadedMessage("Arquivo não encontrado."));
        } catch (IOException ex) {
            System.out.println(getNoPropertyLoadedMessage("Falha na leitura do arquivo."));
        }
    }

    /**
     * Retorna mensagem default de nenhuma propriedade carregada concatenando a
     * causa
     *
     * @param cause
     * @return String
     */
    private String getNoPropertyLoadedMessage(String cause) {
        return "Nenhuma propriedade foi carregada! Motivo: ".concat(cause);
    }

    /**
     * Retorna um parâmetro inteiro
     *
     *
     * @param key Chave
     * @param def Valor default
     * @return int
     */
    public int getInt(String key, int def) {
        return Integer.valueOf(getProperties().getProperty(key, String.valueOf(def)));
    }

    /**
     * Retorna um parâmetro String
     *
     *
     * @param key Chave
     * @param def Valor default
     * @return String
     */
    public String getString(String key, String def) {
        return getProperties().getProperty(key, def);
    }

    /**
     * Printa todas as propriedades carregadas
     *
     * @param output
     */
    public void printAll(PrintStream output) {
        output.println("Propriedades Carregadas:");
        getProperties().forEach((k, v) -> {
            output.println(k.toString().concat("=").concat(v.toString()));
        });
    }

    /**
     * Retorna as propriedades carregadas
     *
     * @return Properties
     */
    private Properties getProperties() {
        return properties;
    }

    /**
     * Retorna a instância Singleton
     *
     * @return PropertyLoader
     */
    public static PropertyLoader get() {
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
            instance = new PropertyLoader();
        }
    }

}
