/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.model;

import br.com.jpe.fat.utils.SystemUtils;
import java.util.Optional;

/**
 *
 * @author Joaov
 */
public class SatPhilosofer extends Philosofer implements Runnable {

    private final Fork leftFork;
    private final Fork rightFork;

    public SatPhilosofer(Fork leftFork, String name, Fork rightFork) {
        super(name);
        this.leftFork = leftFork;
        this.rightFork = rightFork;
    }

    private Optional<SatPhilosofer> left = Optional.empty();
    private Optional<SatPhilosofer> right = Optional.empty();

    public Fork getLeftFork() {
        return leftFork;
    }

    public Fork getRightFork() {
        return rightFork;
    }

    public Optional<SatPhilosofer> getLeft() {
        return left;
    }

    public void setLeft(SatPhilosofer left) {
        this.left = Optional.of(left);
    }

    public Optional<SatPhilosofer> getRight() {
        return right;
    }

    public void setRight(SatPhilosofer right) {
        this.right = Optional.of(right);
    }

    /**
     * Thread method
     */
    @Override
    public void run() {
        // loops while he is alive
        while (this.alive) {
            doLogic();
        }
        SystemUtils.printf("%04d:>\t'%s' is dead, so he cannot eat nor think anymore.", actionCount.incrementAndGet(), getName());
    }

    /**
     * Here is the logic that you're looking for ;)
     *
     * This runs on an eternal loop
     */
    private void doLogic() {
        // if the philosofer has to think, simply think
        if (PhilosoferAction.THINK.equals(this.nextAction)) {
            think();
            return;
        }

        // the philosofer has to eat.
        final SatPhilosofer leftNeighbour = this.getLeft().get();
        final SatPhilosofer rightNeighbour = this.getRight().get();

        // if the neighbours are eating, the forks are busy, so he may think
        if (leftNeighbour.isEating()) {
            this.nextAction = PhilosoferAction.THINK;
            return;
        }

        // grab the left fork
        synchronized (leftFork) {
            // if the neighbours are eating, the forks are busy, so drop the fork and set to think on the next tick
            if (rightNeighbour.isEating()) {
                this.nextAction = PhilosoferAction.THINK;
                return;
            }
            // grab the right fork
            synchronized (rightFork) {
                // if the neighbours are eating, the forks are busy, so drop the fork and set to think on the next tick
                if (leftNeighbour.isEating() || rightNeighbour.isEating()) {
                    this.nextAction = PhilosoferAction.THINK;
                    return;
                }
                // the neightbours are thinking, the forks are with me, so I can eat
                eat(String.format("with forks %2d and %2d", leftFork.getNumber(), rightFork.getNumber()));
            }
        }
    }

}
