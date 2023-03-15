/////////////////////////////////////////////////////////
//                                                     //
//               TRADENCIABOT - MEDIAS/MACD            //
//                                                     //
/////////////////////////////////////////////////////////
   {Programado por Eduardo Cortes e Leonardo Zambiasi}
             {www.tradencia.com.br}


////parametros do indicador: a base da ideia////

  parâmetro
  MediaRapida(9);
  MediaLenta(21);

///variaveis ou referencias para o codigo funcionar///  
  
  var  
  sMedRapida     : Real;
  sMedLenta      : Real;
  sPrevMedRapida : Real;
  sPrevMedLenta  : Real;
  mcd, me        : Real;
  cenario1       : booleano;
  cenario2       : booleano;

///Aqui começamos o bloco do código para definirmos a estrategia que queremos///  
  
 begin
 
///Aqui armazenamos os valores das médias/macd em variáveis de apoio///
///Observar que ao trocar o número do parâmetro mudará aqui////
  
  sMedRapida     := Media(MediaRapida, fechamento);
  sMedLenta      := Media(MediaLenta, Fechamento);
  sPrevMedRapida := sMedRapida[1];
  sPrevMedLenta  := sMedLenta[1];
  mcd := macd(26,12,9);
  me:= mediaexp(9, mcd);  

///estabelecemos qual o cenário ou gatilho de entrada na operação: o cérebro do robô///
      
cenario1 := (sPrevMedRapida < sPrevMedLenta) e (sMedRapida > sMedLenta) e (mcd > me) e (mcd[1] <= me[1]);   ///compra
cenario2 := (sPrevMedRapida > sPrevMedLenta) e (sMedRapida < sMedLenta) e  (mcd < me)e (mcd[1] <= me[1]);   ///venda
 
// Verifica se as condições de disparos foram satisfeitas///

Begin
se cenario1 então

inicio
Se(sellposition > 0) então
paintbar(clgreen);
BuyToCoverAtMarket;
BuyAtMarket;
fim

senão se cenario2 então

inicio

Se(BuyPosition > 0) então
paintbar(clred);
SellToCoverAtMarket;
SellShortAtMarket;
 
fim;
end;
end;