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

    public static void main(String[] args) {

        TableHandler table = new TableHandler();

        Fork f1 = new Fork(1);
        Fork f2 = new Fork(2);
        Fork f3 = new Fork(3);
        Fork f4 = new Fork(4);
        Fork f5 = new Fork(5);

        table.addPhilosofer(new SatPhilosofer(f5, "A", f1));
        table.addPhilosofer(new SatPhilosofer(f1, "B", f2));
        table.addPhilosofer(new SatPhilosofer(f2, "C", f3));
        table.addPhilosofer(new SatPhilosofer(f3, "D", f4));
        table.addPhilosofer(new SatPhilosofer(f4, "E", f5));

        System.out.println("Table disposition:");
        table.printTablePosition();

        System.out.println("Running...");

        table.startParanaues();
        System.out.println("Finished! See the report below:");

        System.out.println("ACTION_ID\tMESSAGE");
        SystemUtils.buffer.stream().sorted((String me, String you) -> {
            try {
                int iMe = Integer.parseInt(me.substring(0, 4).trim());
                int iYou = Integer.parseInt(you.substring(0, 4).trim());
                return iMe - iYou;
            } catch (Exception e) {
                return 0;
            }
        }).forEach(str -> {
            System.out.println(str);
        });

        table.printResults();

    }

}
