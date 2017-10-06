/*
 * AppCliente
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */
package br.perin.app.bean;

/**
 * Descrição da classe.
 */
public class Message {

    private final int cod;
    private final int len;
    private final String msg;

    public Message(int cod, int len, String msg) {
        this.cod = cod;
        this.len = len;
        this.msg = msg;
    }

    public int getCod() {
        return cod;
    }

    public int getLen() {
        return len;
    }

    public String getMsg() {
        return msg;
    }

    @Override
    public String toString() {
        return "Message{" + "cod=" + cod + ", len=" + len + ", msg=" + msg + '}';
    }

}
