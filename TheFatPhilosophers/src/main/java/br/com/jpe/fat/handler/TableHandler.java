/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.handler;

import br.com.jpe.fat.model.SatPhilosofer;
import br.com.jpe.fat.utils.SystemUtils;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Joaov
 */
public class TableHandler {

    private final List<SatPhilosofer> philosofers;

    public TableHandler() {
        this.philosofers = new ArrayList<>();
    }

    public void addPhilosofer(SatPhilosofer philosofer) {
        int listSize = this.philosofers.size();
        // Set neightbours
        if (listSize > 0) {
            SatPhilosofer other = this.philosofers.get(listSize - 1);
            other.setRight(philosofer);
            philosofer.setLeft(other);
        }
        this.philosofers.add(philosofer);
        // Update first and last reference
        var first = this.philosofers.iterator().next();
        philosofer.setRight(first);
        first.setLeft(philosofer);
    }

    public void startParanaues(int timeToRun) {
        // starts all the threads
        philosofers.stream().map(e -> new Thread(e)).forEach(thread -> thread.start());
        SystemUtils.sleep(timeToRun);
        // kill all the philosofers
        philosofers.stream().forEach(guy -> guy.die());
    }

    public void printTablePosition() {
        var i = 0;
        for (var e : philosofers) {
            String left = e.getLeft().isPresent() ? e.getLeft().get().getName() : "x";
            String right = e.getRight().isPresent() ? e.getRight().get().getName() : "x";
            int leftFork = e.getLeftFork().getNumber();
            int rightFork = e.getRightFork().getNumber();
            System.out.printf("%3d =>\t\t%s [%d] (%s) [%d] %s\n", ++i, left, leftFork, e.getName(), rightFork, right);
        }
    }

    public void printResults() {
        var i = 0;
        for (var e : philosofers) {
            System.out.printf("%3d =>\t\tPhilosofer '%s' had think %03d times and eat %03d times. \n", ++i, e.getName(), e.getThinkCount(), e.getEatCount());
        }
    }

}
