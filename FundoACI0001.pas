/// CÓDIGO FUNDO ACI - 001 - BASE DE DERIVAÇÃO N°0001 de N°1000 // CERTIFICADO DE REGISTRO DE PROGRAMA DE COMPUTADOR N°BR12022000611-1///
//  SEJA BEM VINDO AO CENTRO DE INVESTIMENTOS // NOSSA MISÃO É TRANSFORMAR CADA BRASILEIRO EM SEU PROPRIO FUNDO DE INVESTIMENTOS, COM ESTRATÉGIAS ABERTAS.
//  WWW.CENTRODEINVESTIMENTOS.COM.BR // INSTAGRAM : @CENTRODEINVESTIMENTOS // YOUTUBE : CENTRO DE INVESTIMENTOS //
//  CONNECT CHAT PREMIUM : CENTRO DE INVESTIMENTOS.
//  ENTREGAMOS AS DERIVAÇOES 0002 - 0004 - 0005 - 00012 // CÓDIGOS FONTES ABERTO = R$121,00 // TREINAMENTO E INSTALAÇOES DOS SOFTWARE
//  DESENVOLVIMENTO DE ROBÔS//
//  REGISTRO NO INPI O CÓDIGO - FONTE -> SEM QUE PRECISE ENVIAR O CÓDIGO -FONTE.
// MODELO MEDIDOR DE VOLUME FINANCEIRO.
Const
  QtdVol         = 5000000000;
  HrInicio       = 901;
  HrFim          = 1200;
  AlvoMatematico = 1.5;
  stopmatematico = 0;
  tickentrada    = 0;
Var
  Sc,Sv,sc1,sv1,sc2,sv2,sc3,sv3,sc5,sv5 : booleano;
  ssc,ssv : booleano;
  entradaC,entradaV,stopC,alvoC,stopV,alvoV,CA,CV : Real;
  vwapd : float;
  vwaps : float;
  vwapm : float;
  ampsc,ampsv : real;
INICIO
  vwapd := vwap(1);
  //diario
  vwaps := vwap(2);
  //semanal
  vwapm := vwap(3);
  //mensal
  //sc = sinal de compra
  sC := (minima > minima[1]) e (Volume > QtdVol) e (fechamento > abertura) e (fechamento > vwapd) e (fechamento > vwaps) e (fechamento > vwapm) e (time >= HrInicio) e (time < HrFim);
  //sv = sinal de venda
  sV := (maxima < maxima[1]) e (Volume > QtdVol) e (fechamento < abertura) e (fechamento < vwapd) e (fechamento < vwaps) e (fechamento < vwapm) e (time >= HrInicio) e (time < HrFim);
  alvoc := maxima + abs(range * alvomatematico);
  alvov := minima - abs(range * alvomatematico);
  stopc := minima;
  stopv := maxima;
  se sc e not IsBought e not IsSold entao
    // BuyLimit(fechamento);// para execução
    Buyatmarket;
  // para backtest
  se IsBought = verdadeiro entao
    inicio
      SellToCoverLimit(alvoc);
      SellToCoverstop(stopc,stopc);
    fim;
  se sv e not IsBought e not IsSold entao
    // SellShortLimit(fechamento);// para execução
    sellshortatmarket;
  // para backtest
  se IsSold = verdadeiro entao
    inicio
      BuyToCoverLimit(alvov);
      BuyToCoverStop(stopv,stopv);
    fim;
  se (time >= 1700) entao
    inicio
      closeposition;
    fim;
FIM;
      sPct3 := fValorUtilizado * (1 + (Pct3 / 100)); //3
      sPct4 := fValorUtilizado * (1 + (Pct4 / 100)); //4
      sPct5 := fValorUtilizado * (1 - (Pct1 / 100)); //-1
      sPct6 := fValorUtilizado * (1 - (Pct2 / 100)); //-2
      sPct7 := fValorUtilizado * (1 - (Pct3 / 100)); //-3
      sPct8 := fValorUtilizado * (1 - (Pct4 / 100)); //-4
      
      ///Queremos que desenhe o resultado do indicador da formula acima no gráfico///
      
      Plot(sPct1);
      Plot2(sPct2);
      Plot3(sPct3);
      Plot4(sPct4);
      Plot5(sPct5);
      Plot6(sPct6);
      Plot7(sPct7);
      Plot8(sPct8);
      plot9(fValorUtilizado);
      
      ///com indicador pronto pensamos na sua execução automatizada///
                      
                      ///REGRA DE EXECUÇAO///
      
      Inicio
      
      ///estabelecemos qual o cenário ou gatilho de entrada na operação: o cérebro do robô///
      
      cenario1 := (maxima[1] >= spct1) e (abertura[0] <= spct1);
      cenario2 := (maxima[1] >= spct2) e (abertura[0] <= spct2);
      cenario3 := (Maxima[1] >= spct3) e (abertura[0] <= spct3);
      cenario4 := (Maxima[1] >= spct4) e (abertura[0] <= spct4);
      cenario5 := (Minima[1] <= spct5) e (abertura[0] >= spct5);
      cenario6 := (Minima[1] <= spct6) e (abertura[0] >= spct6);
      cenario7 := (Minima[1] <= spct7) e (abertura[0] >= spct7);
      cenario8 := (Minima[1] <= spct8) e (abertura[0] >= spct8);
      
      ///estabelecemos a regra de execução e coloração no candle/box para verificar se está correto///
      
      begin
      
        ///Aqui procuramos ordens de venda com percentual positivo///
      
        Se (cenario1 ou cenario2 ou cenario3 ou cenario4) e (Time >= HoraInicio) e (sellposition=0) então
          begin
            paintbar(clred);
            SellShortAtMarket;
          end;
      
        ///Aqui estabelecemos alvos de ganhos e limites de perda///
      
        Begin
          if ((IsSold and (close < (SellPrice - alvo))) or (IsSold and (close > (SellPrice + stop)))) then
            closeposition;
        end;
      end;
      
      ///Aqui procuramos ordens de compra com percentual negativo///
      
      begin
        se (cenario5 ou cenario6 ou cenario7 ou cenario8) e (Time >= HoraInicio) e (buyposition=0) então
          begin
            PaintBar(clblue);
            BuyAtMarket;
          end;
      
        ///Aqui estabelecemos alvos de ganhos e limites de perda///
        Begin
          if ((Isbought and (close > (buyprice + alvo))) or (Isbought and (close < (buyprice - stop)))) then
            closeposition;
      
          ///Fechar Posiçoes em horário determinado///
          Se (Time >= HoraFechamento) entao
            ClosePosition;
end;
end;
end;
end;