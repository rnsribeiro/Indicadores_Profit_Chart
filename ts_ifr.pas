/////////////////////////////////////////////////////////
//                                                     //
//                      IFR                            //
//                                                     //
/////////////////////////////////////////////////////////
begin
  // Verifica se está vendido
  if (IsSold) then
    begin
      // Fecha a posição com uma compra caso
      // o IFR esteja superior a 70
      if (RSI(9, 0) > 65) then
        BuyToCoverAtMarket;
    end     
  // Verifica se está comprado
  else if (IsBought) then
    begin
      // Fecha a posição com uma venda caso
      // o IFR esteja inferior a 30
      if (RSI(9, 0) < 35) then
        SellToCoverAtMarket;
    end
  // Verifica se deve abrir uma posição de venda
  // utilizando o valor do IFR    
  else if (RSI(9, 0) > 65) then
    BuyAtMarket
  else if (RSI(9, 0) < 35) then
    SellShortAtMarket;
end;