// Define a propriedade startsWith da String
if (!String.prototype.startsWith){
   String.prototype.startsWith = function(ctx){
      return this && ctx && this.indexOf(ctx) === 0;
   }
}

// Indicador de "tente novamente"
var TRY_AGAIN = false;

// Roda a aplica��o do client
(function(){
   app.print("[CLI]Start...");
   do {
      TRY_AGAIN = false;
      doComm();
   } while(TRY_AGAIN);
   app.print("[CLI]End.");
})();

/**
 * Realiza a comunica��o
 */
function doComm(){
   app.print("Iniciando comunica��o...");
   var ret = client.sendMessage("1000000");
   // Protocolo incorreto.
   if (ret.startsWith("999")) {
      app.alert("O servidor informou que o protocolo est� incorreto!");
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
         app.info("Mensagem do dia: " + ret.substring(7, 7 + tam));
      } else {
         app.alert("Falha na comunica��o com o servidor!");
      }
   } else if (ret.startsWith("102")) {
      // Se o servidor estiver ocupado, n�o � necess�rio encerrar comunica��o
      TRY_AGAIN = app.confirm("O servidor est� ocupado. Deseja tentar novamente?")
      return;
   } else {
      app.print("Retorno n�o reconhecido: " + ret);
      app.alert("O retorno do servidor n�o foi reconhecido.");
   }
   // Encerra comunica��o
   app.print("Encerrando comunica��o...");
   ret = client.sendMessage("9000000");
   // Se comunicou com sucesso:
   if (ret.startsWith("901")) {
      app.print("Comunica��o encerrada com sucesso :D");
   } else {
      app.print("Falha ao encerrar comunica��o. Retorno:" + ret);
   }
}