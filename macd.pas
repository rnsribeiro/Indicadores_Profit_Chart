///////////////////////////////////////////////////////////////////
//                               MACD                           //  
///////////////////////////////////////////////////////////////////
input
  FastPeriod(12);
  SlowPeriod(26);
  TriggerPeriod(9);
var
  sFast    : Float;
  sSlow    : Float;
  sTrigger : Float;
begin
  if (CurrentBar > SlowPeriod) then
    begin
      /////////////////////////
      // Calcula os necessários
      sFast    := MediaExp(FastPeriod, Close);
      sSlow    := MediaExp(SlowPeriod, Close);
      sTrigger := MediaExp(TriggerPeriod, sFast - sSlow);

      /////////////////////
      // Desenha o resultado
      Plot (sFast - sSlow);
      Plot2(sTrigger);
    end;
end;