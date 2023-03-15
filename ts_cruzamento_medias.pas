/////////////////////////////////////////////////////////
//                                                     //
//               Cruzamento de Médias                  //
//                                                     //
/////////////////////////////////////////////////////////
parâmetro
  MediaRapida(9);
  MediaLenta(21);
var  
  sMedRapida     : Real;
  sMedLenta      : Real;
  sPrevMedRapida : Real;
  sPrevMedLenta  : Real;
begin
  ///////////////////////////////////////////////////////
  // Armazena os valores das médias em variáveis de apoio
  sMedRapida     := Media(MediaRapida, Fechamento);
  sMedLenta      := Media(MediaLenta, Fechamento);
  sPrevMedRapida := sMedRapida[1];
  sPrevMedLenta  := sMedLenta[1];

  ///////////////////////////////////////////////////////
  // Verifica se as condições de disparos de alarmes
  // foram satisfeitas
  se (sPrevMedRapida < sPrevMedLenta) e (sMedRapida > sMedLenta) então
    inicio
      Se(isSold = true) então
        BuyToCoverAtMarket;
      BuyAtMarket;
    fim
  senão se (sPrevMedRapida > sPrevMedLenta) e (sMedRapida < sMedLenta) então
    inicio
      Se(isBought = true) então
        SellToCoverAtMarket;
      SellShortAtMarket; 
    fim;
end;