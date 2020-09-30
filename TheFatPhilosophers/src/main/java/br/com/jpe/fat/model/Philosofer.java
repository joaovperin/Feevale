/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.model;

import static br.com.jpe.fat.Main.EAT_TIME;
import static br.com.jpe.fat.Main.THINK_TIME;
import br.com.jpe.fat.utils.SystemUtils;
import java.util.concurrent.atomic.AtomicInteger;

/**
 *
 * @author Joaov
 */
public class Philosofer {

    /** just a counter for the actions */
    protected static AtomicInteger actionCount = new AtomicInteger(0);

    /** controls the thread loop */
    protected boolean alive;

    protected final String name;
    protected PhilosoferAction nextAction;

    /**
     * data for the reports
     */
    protected int thinkCount = 0;
    protected int eatCount = 0;

    public Philosofer(String name) {
        this.name = name;
        this.alive = true;
        this.nextAction = PhilosoferAction.THINK;
    }

    public String getName() {
        return name;
    }

    public boolean isThinking() {
        return PhilosoferAction.THINK.equals(this.nextAction);
    }

    public boolean isEating() {
        return PhilosoferAction.EAT.equals(this.nextAction);
    }

    public void think() {
        SystemUtils.printf("%04d:>\t'%s' is meditating", actionCount.incrementAndGet(), getName());
        this.thinkCount++;
        SystemUtils.sleep(THINK_TIME);
        this.nextAction = PhilosoferAction.EAT;
    }

    public void eat(String msg) {
        SystemUtils.printf("%04d:>\t'%s' is eating %s", actionCount.incrementAndGet(), getName(), msg);
        this.eatCount++;
        SystemUtils.sleep(EAT_TIME);
        this.nextAction = PhilosoferAction.THINK;
    }

    public int getThinkCount() {
        return thinkCount;
    }

    public int getEatCount() {
        return eatCount;
    }

    public void die() {
        this.alive = false;
    }

}
