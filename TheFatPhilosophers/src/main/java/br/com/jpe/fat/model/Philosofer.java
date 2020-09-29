/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.model;

import br.com.jpe.fat.utils.SystemUtils;
import java.util.concurrent.atomic.AtomicInteger;

/**
 *
 * @author Joaov
 */
public class Philosofer {

    private static final int THINK_TIME = 50;
    private static final int EAT_TIME = 50;

    protected static AtomicInteger actionCount = new AtomicInteger(0);

    protected boolean alive;

    protected final String name;
    protected PhilosoferStatus status;

    protected int thinkCount = 0;
    protected int eatCount = 0;

    public Philosofer(String name) {
        this.name = name;
        alive = true;
        this.status = PhilosoferStatus.THINKING;
    }

    public String getName() {
        return name;
    }

    public boolean isThinking() {
        return PhilosoferStatus.THINKING.equals(this.status);
    }

    public boolean isEating() {
        return PhilosoferStatus.EATING.equals(this.status);
    }

    public void think() {
        SystemUtils.printf("%04d:>\t'%s' is meditating", actionCount.incrementAndGet(), getName());
        this.thinkCount++;
        SystemUtils.sleep(THINK_TIME);
        this.status = PhilosoferStatus.THINKING;
    }

    public void eat(String msg) {
        SystemUtils.printf("%04d:>\t'%s' is eating %s", actionCount.incrementAndGet(), getName(), msg);
        this.eatCount++;
        SystemUtils.sleep(EAT_TIME);
        this.status = PhilosoferStatus.EATING;
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
