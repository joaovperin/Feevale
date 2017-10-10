/*
 * AppCliente
 * CopyRight Rech Informática Ltda. Todos os direitos reservados.
 */
package br.perin.app.services;

import br.perin.app.bean.Message;

/**
 * Parser de uma mensagem
 */
public class MessageParser {

    //
    // 1-3 = cod
    // 4-7 = tamanho
    // 8-2000 = msg
    //
    /**
     * Realiza o Parse de uma mensagem
     *
     * @param crudeMsg
     * @return Message
     */
    public Message parse(String crudeMsg) {
        try {
            return doParse(crudeMsg);
        } catch (Exception e) {
            throw new IllegalArgumentException("Falha ao parsear mensagem: ".concat(crudeMsg), e);
        }
    }

    /**
     * Realiza o parse da mensagem
     *
     * @param crudeMsg
     * @return Message
     */
    private Message doParse(String crudeMsg) {
        int cod = Integer.valueOf(crudeMsg.substring(0, 3));
        int size = Integer.valueOf(crudeMsg.substring(3, 6));
        String msg = crudeMsg.substring(6, crudeMsg.length());
        return new Message(cod, size, msg);
    }

}
