// Define a propriedade startsWith da String
if (!String.prototype.startsWith){
   String.prototype.startsWith = function(ctx){
      return this && ctx && this.indexOf(ctx) === 0;
   }
}

// Indicador de "tente novamente"
var TRY_AGAIN = false;

// Roda a aplicação do client
(function(){
   app.print("[CLI]Start...");
   do {
      TRY_AGAIN = false;
      doComm();
   } while(TRY_AGAIN);
   app.print("[CLI]End.");
})();

/**
 * Realiza a comunicação
 */
function doComm(){
   app.print("Iniciando comunicação...");
   var ret = client.sendMessage("1000000");
   // Protocolo incorreto.
   if (ret.startsWith("999")) {
      app.alert("O servidor informou que o protocolo está incorreto!");
      return;
   }
   // Se comunicou com sucesso:
   if (ret.startsWith("101")) {
      app.print("Servidor pronto para comunicação!");
      // Solicita mensagem do dia
      ret = client.sendMessage("2000000");
      if (ret.startsWith("201")) {
         // Obtém o tamanho da mensagem
         var tam = parseInt(ret.substring(3, 7));
         app.info("Mensagem do dia: " + ret.substring(7, 7 + tam));
      } else {
         app.alert("Falha na comunicação com o servidor!");
      }
   } else if (ret.startsWith("102")) {
      // Se o servidor estiver ocupado, não é necessário encerrar comunicação
      TRY_AGAIN = app.confirm("O servidor está ocupado. Deseja tentar novamente?")
      return;
   } else {
      app.print("Retorno não reconhecido: " + ret);
      app.alert("O retorno do servidor não foi reconhecido.");
   }
   // Encerra comunicação
   app.print("Encerrando comunicação...");
   ret = client.sendMessage("9000000");
   // Se comunicou com sucesso:
   if (ret.startsWith("901")) {
      app.print("Comunicação encerrada com sucesso :D");
   } else {
      app.print("Falha ao encerrar comunicação. Retorno:" + ret);
   }
}