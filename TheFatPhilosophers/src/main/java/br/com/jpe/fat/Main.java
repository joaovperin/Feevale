/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.jpe.fat;

import br.com.jpe.fat.handler.TableHandler;
import br.com.jpe.fat.model.Fork;
import br.com.jpe.fat.model.SatPhilosofer;
import br.com.jpe.fat.utils.SystemUtils;

/**
 *
 * @author Joaov
 */
public class Main {

    /**
     * Duration (in ms) of the eat and think actions.
     *
     * TRY CHANGING THE VALUES AND SEE THE EFFECT!
     */
    public static final int THINK_TIME = 50;
    public static final int EAT_TIME = 50;

    /** Run for this time (in ms) and stops */
    private static final int RUN_TIME = 5017;

    public static void main(String[] args) {

        // create the table
        TableHandler table = new TableHandler();

        // create some forks
        Fork f1 = new Fork(1);
        Fork f2 = new Fork(2);
        Fork f3 = new Fork(3);
        Fork f4 = new Fork(4);
        Fork f5 = new Fork(5);

        // adds some philosofers, with the respective forks on the sides
        table.addPhilosofer(new SatPhilosofer(f5, "AAA", f1));
        table.addPhilosofer(new SatPhilosofer(f1, "BBB", f2));
        table.addPhilosofer(new SatPhilosofer(f2, "CCC", f3));
        table.addPhilosofer(new SatPhilosofer(f3, "DDD", f4));
        table.addPhilosofer(new SatPhilosofer(f4, "EEE", f5));

        // shows the table disposition
        System.out.println("Table disposition:");
        table.printTablePosition();

        // starts to run
        System.out.println("\nRunning...");
        System.out.println("ACTION_ID\tMESSAGE");
        table.startParanaues(RUN_TIME);

        // await some time for the finishing tasks and print the results
        SystemUtils.sleep((THINK_TIME + EAT_TIME) * 2);
        System.out.println("\nFinished! See the report below:");
        table.printResults();

    }

}
