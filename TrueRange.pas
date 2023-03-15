///////////////////////////////////////////////////////////////////
//                            True Range                         //
///////////////////////////////////////////////////////////////////
var
  sTR    : Float;   // Valor atual do TR
begin
  if CurrentBar > 0 then
    begin
      /////////////////////////
      //Encontra o valor do TR
      sTR := abs(Low - Close[1]);
      if (High - Low) > sTR then 
        sTR := High - Low;
      if abs(High - Close[1]) > sTR then 
        sTR := abs(High - Close[1]);

      ///////////////////////////////////
      //Desenha no gráfico o valor do TR     
      Plot(sTR);
    end;
end;