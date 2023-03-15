///////////////////////////////////////////////////////////////////
//                               MediaExp                        //  
///////////////////////////////////////////////////////////////////
input
  Periodo(20);
  Dados(Close);
var
  nIndex  : Integer;
  sSum    : Float;
  sResult : Float;
  sFactor : Float;
begin
  //////////////////
  // Primeiro valor
  if (CurrentBar = Periodo-1) then
    begin
      sSum := 0;
      for nIndex := 0 to Periodo-1 do
        sSum := sSum + Dados[nIndex];
      sResult := sSum / Periodo;
      //////////////////////////////////////////
      // Retorna o resultado da primeira posição 
      Plot(sResult);
    end
  //////////////////
  // Demais valores
  else if (CurrentBar > Periodo-1) then
    begin
      sFactor := 2 / (Periodo + 1);
      sResult := Dados * sFactor + sResult[1] * (1 - sFactor);
      ///////////////////////////////////////
      // Retorna o resultado da posição atual
      Plot(sResult);
    end;
end;

