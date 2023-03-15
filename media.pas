///////////////////////////////////////////////////////////////////
//                               Media                           //  
///////////////////////////////////////////////////////////////////
input
  Periodo(200);
  Dados(Close);
var
  nIndex : Integer;
  sSum   : Float;
begin
  //////////////////
  // Primeiro valor 
  if (CurrentBar = Periodo-1) then
    begin
      sSum := 0;
      For nIndex := 0 to Periodo-1 do
        sSum := sSum + Dados[nIndex];
      //////////////////////////////////////////
      // Retorna o resultado da primeira posição 
      Plot(sSum / Periodo);
    end
  //////////////////
  // Demais valores
  else if (CurrentBar > Periodo-1) then
    begin
      sSum := sSum[1] + Dados - Dados[Periodo];
      ///////////////////////////////////////
      // Retorna o resultado da posição atual
      Plot(sSum / Periodo);
    end;
end;