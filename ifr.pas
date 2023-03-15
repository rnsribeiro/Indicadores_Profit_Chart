///////////////////////////////////////////////////////////////////
//                               IFR                             // 
///////////////////////////////////////////////////////////////////
input
  Periodo(14);
var
  sHighs  : Float;
  sLows   : Float;           
  nIndex  : Integer;
  sRatio  : Float;
  sResult : Float;
begin
  if (CurrentBar = Periodo-1) then
    begin
      //////////////////////////////
      // Primeira cotação
      sHighs := 0;
      sLows  := 0;
      For nIndex := 0 to Periodo-2 do
        begin
          if (Close[nIndex] > Close[nIndex+1])
            then sHighs := sHighs + Close[nIndex] - Close[nIndex+1]
            else sLows  := sLows  - Close[nIndex] + Close[nIndex+1];
        end;

      if (sLows <> 0)
        then sResult := 100 - (100/(1+(sHighs/sLows)))
        else sResult := 100;
      Plot(sResult);
    end
  else if (CurrentBar >= Periodo) then
    begin
      //////////////////////////////
      // Demais cotações
      sRatio := (Periodo-1) / Periodo;
      sHighs := sHighs[1] * sRatio;
      sLows  := sLows[1]  * sRatio;
      if (Close > Close[1])
        then sHighs := sHighs + ( Close - Close[1])*sRatio
        else sLows  := sLows  + (-Close + Close[1])*sRatio;

      if (sLows <> 0)
        then sResult := 100 - (100/(1+(sHighs/sLows)))
        else sResult := 100;
      Plot(sResult);

      //////////////////////////////
      // Paint
      if (sResult < 30) then
        PaintBar(clGreen)
      else if (sResult > 70) then
        PaintBar(clRed);
    end;  
end;