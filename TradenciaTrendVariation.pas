/////////////////////////////////////////////////////////
//                                                     //
//               TRADENCIABOT - TRENDVARIATION         //
//                                                     //
/////////////////////////////////////////////////////////
  {Programado por Eduardo Cortes e Leonardo Zambiasi}
             {www.tradencia.com.br} 

////parametros do indicador: a base da ideia////

Input
  Tipo (1);
  Dias_Retroativos(60);
  Pct1(0.5);
  Pct2(1.0);
  Pct3(1.5);
  Pct4(2.0);
  HoraInicio(0905);
  HoraFechamento(1700);
  Alvo(5);
  Stop(5);

  ///variaveis ou referencias para o codigo funcionar///
var
  fValorUtilizado                     : Float;
  sPct1                               : Float;
  sPct2                               : Float;
  sPct3                               : Float;
  sPct4                               : Float;
  sPct5                               : Float;
  sPct6                               : Float;
  sPct7                               : Float;
  sPct8                               : Float;
  cenario1,cenario2,cenario3,cenario4 : booleano;
  cenario5,cenario6,cenario7,cenario8 : booleano;

  ///Aqui começamos o bloco do código para definirmos a estrategia que queremos///

  Begin

  ///formula para limitar os dias que o codigo irá executar/////
  
  se (LastCalcDate > CalcDate(CurrentDate, - (Dias_Retroativos))) então
  
 
      ///definimos nosso primeiro parametro da variavel - o tipo de pivot///
  
if Tipo = 1 then begin fValorUtilizado := Priorcote(0); end;    //fechamento do dia anterior
if Tipo = 2 then begin fValorUtilizado := Opend(0); end;        //Abertura do dia
if Tipo = 3 then begin fValorUtilizado := PriorCote(2); end;    //Máxima do dia anterior
if Tipo = 4 then begin fValorUtilizado := PriorCote(3); end;    //Mínima do dia anterior
if Tipo = 5 then begin fValorUtilizado := PriorCote(4); end;    //Ajuste do dia anterior
if Tipo = 6 then begin fValorUtilizado := Vwap(1); end;         //Vwap diaria
if Tipo = 7 then begin fValorUtilizado := Vwap(2); end;         //Vwap semanal
if Tipo = 8 then begin fValorUtilizado := Vwap(3); end;         //Vwap Mensal


      ///definimos as fórmulas do que acontecerá o parametro das variaveis///
      
      sPct1 := fValorUtilizado * (1 + (Pct1 / 100)); //1
      sPct2 := fValorUtilizado * (1 + (Pct2 / 100)); //2
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