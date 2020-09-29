/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat.model;

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

    @Override
    public void run() {
        // loops while he is alive
        while (this.alive) {
            // case he was thinking, try to eat
            if (PhilosoferStatus.THINKING.equals(this.status)) {
                final SatPhilosofer leftNeighbour = this.getLeft().get();
                final SatPhilosofer rightNeighbour = this.getRight().get();

                // if the neightbours are thinking, the forks are idle so he can eat
                synchronized (leftFork) {
                    synchronized (rightFork) {
                        if (leftNeighbour.isThinking() && rightNeighbour.isThinking()) {
                            eat(String.format("with forks %2d and %2d", leftFork.getNumber(), rightFork.getNumber()));
                        }
                    }
                }
            } else {
                // if he cannot eat, keeps thinking
                think();

            }
        }
    }

}
