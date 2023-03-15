/////////////////////////////////////////////////////////
//                                                     //
//               Cruzamento de Médias                  //
//                                                     //
/////////////////////////////////////////////////////////
input
  FastAverage(9);
  SlowAverage(21);
var  
  sAvgFast     : Float;
  sAvgSlow     : Float;
  sPrevAvgFast : Float;
  sPrevAvgSlow : Float;
begin
  ///////////////////////////////////////////////////////
  // Armazena os valores das médias em variáveis de apoio
  sAvgFast     := Media(FastAverage, Close);
  sAvgSlow     := Media(SlowAverage, Close);
  sPrevAvgFast := sAvgFast[1];
  sPrevAvgSlow := sAvgSlow[1];

  ///////////////////////////////////////////////////////
  // Verifica se as condições de disparos de alarmes
  // foram satisfeitas
  if (sPrevAvgFast < sPrevAvgSlow) and (sAvgFast > sAvgSlow) then
    Alert(clGreen)
  else if (sPrevAvgFast > sPrevAvgSlow) and (sAvgFast < sAvgSlow) then
    Alert(clRed); 
end;