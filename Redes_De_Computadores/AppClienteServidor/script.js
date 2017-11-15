// Define a propriedade startsWith da String
if (!String.prototype.startsWith){
   String.prototype.startsWith = function(ctx){
      return this && ctx && this.indexOf(ctx) === 0;
   }
}

// Define a propriedade substring da String
if (!String.prototype.substring){
   String.prototype.subtring = function(ctx){
	// TODO: A implementar...
	return this;
   }
}

// Roda a aplica��o do client
(function(){
   app.alert("[CLI]Start...");
   doComm();
   app.alert("[CLI]End.");
})();

/**
 * Realiza a comunica��o
 */
function doComm(){
   app.print("Iniciando comunica��o...");
   var ret = client.sendMessage("1000000");
   // Protocolo incorreto.
   if (ret.startsWith("999")) {
      app.print("O servidor informou que o protocolo est� incorreto!");
      return;
   }
   // Se comunicou com sucesso:
   if (ret.startsWith("101")) {
      app.print("Servidor pronto para comunica��o!");
      // Solicita mensagem do dia
      ret = client.sendMessage("2000000");
      if (ret.startsWith("201")) {
         // Obt�m o tamanho da mensagem
         var tam = parseInt(ret.substring(3, 7));
         app.print("Mensagem do dia: " + ret.substring(7, 7 + tam));
         } else {
            app.print("Falha na comunica��o!");
         }
      } else if (ret.startsWith("102")) {
         // Se o servidor estiver ocupado, n�o � necess�rio encerrar comunica��o
         app.print("O servidor est� ocupado. Tente novamente mais tarde!");
         return;
      } else {
         app.print("Retorno n�o reconhecido: " + ret);
      }
      app.print("Encerrando comunica��o...");
      // Encerra comunica��o
      ret = client.sendMessage("9000000");
      // Se comunicou com sucesso:
      if (ret.startsWith("901")) {
         app.print("Comunica��o encerrada com sucesso :D");
      } else {
         app.print("Falha ao encerrar comunica��o. Retorno:" + ret);
      }
}