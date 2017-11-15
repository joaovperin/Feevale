/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.perin.app;

import br.perin.app.inject.App;
import br.perin.app.inject.Client;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import javax.script.ScriptEngine;
import javax.script.ScriptException;
import jdk.nashorn.api.scripting.NashornScriptEngineFactory;

/**
 * Aplicação via Script
 *
 * @author Joaov
 */
public class ScriptApplication {

    /** Instância do Singleton */
    private static ScriptApplication instance;

    /** Engine interpretadora de Scripts */
    public final ScriptEngine engine;

    /**
     * Construtor privado
     */
    private ScriptApplication(ScriptEngine engine) {
        this.engine = engine;
    }

    /**
     * Inicia a execução do Script
     *
     * @param scriptFile
     * @throws ScriptException Problemas na interpretação
     */
    public void start(String scriptFile) throws ScriptException {
        System.out.println("[SV]Start.");
        try (FileReader fr = new FileReader(new File(scriptFile))) {
            engine.eval(fr);
        } catch (IOException e) {
            throw new ScriptException("Falha ao ler Script do arquivo: ".concat(scriptFile) + ".");
        }
        System.out.println("[SV]End.");
    }

    /**
     * Retorna a instância do Singleton
     *
     * @return ScriptApplication
     */
    public static ScriptApplication get() {
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
            ScriptEngine e = new NashornScriptEngineFactory().getScriptEngine();
            e.put("app", new App());
            e.put("client", new Client());
            instance = new ScriptApplication(e);
        }
    }

}
