
import java.io.File;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * ClienteRMIExemplos.java
 *
 * Created on Apr 10, 2010, 12:17:33 PM
 */
/**
 *
 * @author Gabriel
 */
public class ClienteRMIExemplos extends javax.swing.JFrame {

    /** Creates new form ClienteRMIInverteString */
    public ClienteRMIExemplos() {
        initComponents();
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        txtHost = new javax.swing.JTextField();
        txtLabel = new javax.swing.JTextField();
        txtEntradaTexto = new javax.swing.JTextField();
        btConectar = new javax.swing.JButton();
        btInverter = new javax.swing.JButton();
        txtResultado = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        btConcatenar = new javax.swing.JButton();
        txtN1 = new javax.swing.JTextField();
        txtN2 = new javax.swing.JTextField();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        btSomar = new javax.swing.JButton();
        txtMensagem = new javax.swing.JTextField();
        jLabel7 = new javax.swing.JLabel();
        btEnviar = new javax.swing.JButton();
        txtArquivo = new javax.swing.JTextField();
        btEnviarArquivo = new javax.swing.JButton();
        btConverteMai = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Cliente RMIExemplos");
        setResizable(false);

        jLabel1.setText("Host do Servidor");

        jLabel2.setText("Texto");

        jLabel3.setText("Resultado");

        txtHost.setText("localhost");

        txtLabel.setText("servidor");

        btConectar.setText("Conectar");
        btConectar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btConectarActionPerformed(evt);
            }
        });

        btInverter.setText("Inverter");
        btInverter.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btInverterActionPerformed(evt);
            }
        });

        jLabel4.setText("R�tulo");

        btConcatenar.setText("Concatenar");
        btConcatenar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btConcatenarActionPerformed(evt);
            }
        });

        jLabel5.setText("N1");

        jLabel6.setText("N2");

        btSomar.setText("Somar");
        btSomar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btSomarActionPerformed(evt);
            }
        });

        jLabel7.setText("Menssagem");

        btEnviar.setText("Enviar");
        btEnviar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btEnviarActionPerformed(evt);
            }
        });

        btEnviarArquivo.setText("Enviar Arquivo");
        btEnviarArquivo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btEnviarArquivoActionPerformed(evt);
            }
        });

        btConverteMai.setText("Maiusculo");
        btConverteMai.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btConverteMaiActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel4)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(txtLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 228, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                .addComponent(jLabel1)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(txtHost, javax.swing.GroupLayout.PREFERRED_SIZE, 228, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                .addComponent(jLabel5)
                                .addComponent(jLabel2))
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                .addComponent(txtN1)
                                .addComponent(txtEntradaTexto, javax.swing.GroupLayout.DEFAULT_SIZE, 228, Short.MAX_VALUE))))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel7)
                            .addComponent(jLabel6)
                            .addComponent(jLabel3))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(txtN2)
                            .addComponent(txtResultado, javax.swing.GroupLayout.DEFAULT_SIZE, 228, Short.MAX_VALUE)
                            .addComponent(txtMensagem, javax.swing.GroupLayout.DEFAULT_SIZE, 228, Short.MAX_VALUE)
                            .addComponent(txtArquivo))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btEnviar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btEnviarArquivo, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(btSomar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btConcatenar, javax.swing.GroupLayout.DEFAULT_SIZE, 132, Short.MAX_VALUE)
                        .addComponent(btInverter, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btConectar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btConverteMai, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(txtHost, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtLabel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel4)
                    .addComponent(btConectar))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtEntradaTexto, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel2)
                    .addComponent(btInverter))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btConcatenar)
                    .addComponent(txtN1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel5))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtN2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel6)
                    .addComponent(btSomar))
                .addGap(7, 7, 7)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtResultado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3)
                    .addComponent(btConverteMai))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtMensagem, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel7)
                    .addComponent(btEnviar))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtArquivo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btEnviarArquivo))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btConectarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btConectarActionPerformed
        // TODO add your handling code here:
        if (txtHost.getText().length() == 0 || txtLabel.getText().length() == 0) {
            JOptionPane.showMessageDialog(this, "Digite valores para Host e R�tulo!");
            return;
        }

        try {
            registry = LocateRegistry.getRegistry(txtHost.getText(),8090);
            rmiEx = (InterfaceRMIExemplos) registry.lookup(txtLabel.getText());
            btConectar.setEnabled(false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btConectarActionPerformed

    private void btInverterActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btInverterActionPerformed
        if (txtEntradaTexto.getText().length() < 2) {
            JOptionPane.showMessageDialog(this, "Digite um String com pelo menos 2 caracteres!");
            return;
        }

        try {
            // TODO add your handling code here:
            String txtOriginal = txtEntradaTexto.getText();            
            String txtInvertido = rmiEx.inverteString(txtOriginal);
            txtResultado.setText(txtInvertido);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btInverterActionPerformed

    private void btConcatenarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btConcatenarActionPerformed
        // TODO add your handling code here:
        if (txtEntradaTexto.getText().length() < 2) {
            JOptionPane.showMessageDialog(this, "Digite um String com pelo menos 2 caracteres!");
            return;
        }

        try {
            // TODO add your handling code here:
            String txtOriginal = txtEntradaTexto.getText();
            String txtInvertido = rmiEx.concatenaString(txtOriginal);
            txtResultado.setText(txtInvertido);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btConcatenarActionPerformed

    private void btSomarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btSomarActionPerformed
        // TODO add your handling code here:
        if (txtN1.getText().length() == 0 || txtN2.getText().length() == 0) {
            JOptionPane.showMessageDialog(this, "Digite um String com pelo menos 2 caracteres!");
            return;
        }

        try {
            // TODO add your handling code here:
            String strN1 = txtN1.getText();
            String strN2 = txtN2.getText();
            String resultado = rmiEx.somaNumeros(strN1, strN2);
            txtResultado.setText(resultado);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btSomarActionPerformed

    private void btEnviarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btEnviarActionPerformed
        // TODO add your handling code here:
        if (txtMensagem.getText().length() == 0) {
            JOptionPane.showMessageDialog(this, "Digite um String com pelo menos 2 caracteres!");
            return;
        }

        try {
            // TODO add your handling code here:
            String txtN1 = txtMensagem.getText();
            rmiEx.exibeMsg(txtN1);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }//GEN-LAST:event_btEnviarActionPerformed

    private void btEnviarArquivoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btEnviarArquivoActionPerformed
        // TODO add your handling code here:
        JFileChooser fC = new JFileChooser();
        int result = fC.showOpenDialog(this);
        if (result == JFileChooser.APPROVE_OPTION) {
            txtArquivo.setText(fC.getSelectedFile().getAbsolutePath());
            try {
                File f = fC.getSelectedFile();                
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }//GEN-LAST:event_btEnviarArquivoActionPerformed

    private void btConverteMaiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btConverteMaiActionPerformed
        // TODO add your handling code here:
        try {
            txtResultado.setText(rmiEx.converteMaiusculo(txtEntradaTexto.getText()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }//GEN-LAST:event_btConverteMaiActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {

            public void run() {
                new ClienteRMIExemplos().setVisible(true);
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btConcatenar;
    private javax.swing.JButton btConectar;
    private javax.swing.JButton btConverteMai;
    private javax.swing.JButton btEnviar;
    private javax.swing.JButton btEnviarArquivo;
    private javax.swing.JButton btInverter;
    private javax.swing.JButton btSomar;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JTextField txtArquivo;
    private javax.swing.JTextField txtEntradaTexto;
    private javax.swing.JTextField txtHost;
    private javax.swing.JTextField txtLabel;
    private javax.swing.JTextField txtMensagem;
    private javax.swing.JTextField txtN1;
    private javax.swing.JTextField txtN2;
    private javax.swing.JTextField txtResultado;
    // End of variables declaration//GEN-END:variables
    private Registry registry;
    private InterfaceRMIExemplos rmiEx;
}
