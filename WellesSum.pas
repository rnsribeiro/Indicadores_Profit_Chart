///////////////////////////////////////////////////////////////////
//                           Welles Summation                    //
///////////////////////////////////////////////////////////////////
input
  Periodo(20);
  Dados(Close);
  Offset(0);
var
  nIndex  : Integer;
  sSum    : Float;
  sResult : Float;  
  sFactor : Float;
begin
  //////////////////////////////////////////
  //Começa o cálculo apenas após um período
  if (CurrentBar = Periodo - 1 + Offset) then
    begin
      //////////////////////////
      //Calcula o valor inicial
      sSum := 0;
      for nIndex := 0 to Periodo-1 do
        sSum := sSum + Dados[nIndex];
      sResult := sSum;
      /////////////////////
      //Retorna o resultado
      Plot(sResult);
    end
  else if (CurrentBar > Periodo - 1 + Offset) then
    begin
      /////////////////
      //Calcula o valor
      sFactor := (Periodo-1) / Periodo;
      sResult := Dados + (sResult[1] * sFactor);
      /////////////////////
      //Retorna o resultado
      Plot(sResult);
    end;
end;

