/////////////////////////////////////////////////////////
//                                                     //
//           TRADENCIABOT - RETORNO A MÉDIA            //
//                                                     //
/////////////////////////////////////////////////////////
   {Programado por Eduardo Cortes e Leonardo Zambiasi}
             {www.tradencia.com.br}


////parametros do indicador que serão utilizados////

Input
Dias_Retroativos (30);
HoraInicio(0905);
HoraFechamento(1700);
             
///Começamos com as variaveis ou referencias para o codigo funcionar///  

var
  mm       : Real;
  cenario1 : Booleano;
  cenario2 : Booleano;

///Aqui começamos o bloco do código para definirmos a estrategia que queremos/// 

Begin

///formula para limitar os dias que o codigo irá executar/////

  se (LastCalcDate > CalcDate(CurrentDate, - (Dias_Retroativos))) então

 
///estabelecemos qual o cenário ou gatilho de entrada na operação: o cérebro do robô///

  mm := tilson(0.55,72);
  cenario1 := (Maxima[1] < mm) e (Maxima[0] > mm); ///venda
  cenario2 := (Minima[1] > mm) e (Minima[0] < mm); ///compra
  
  
/// Verifica se as condições de disparos  foram satisfeitas///

begin
Se cenario2 então
begin
 Se (isbought = false) e (Time >= HoraInicio) e (buyposition = 0) então
begin
 paintbar(clblue);
 BuyToCoverAtMarket;
BuyAtMarket;
end;
end
else if cenario1 então
inicio
Se (issold = false) e (Time >= HoraInicio) e (sellposition = 0) então
paintbar(clred);
SellToCoverAtMarket;
SellShortAtMarket;
end;
end;  

///Fechar Posiçoes em horário determinado///
Se (Time >= HoraFechamento) entao
ClosePosition;

end; 