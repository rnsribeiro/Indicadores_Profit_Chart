///////////////////////////////////////////////////////////////////
//                               PaintVar                        //  
///////////////////////////////////////////////////////////////////
begin
  ///////////////////
  // Colore o gráfico
  if (Close = Close[1]) then
    PaintBar(clYellow)
  else if (Close > Close[1]) then
    PaintBar(clGreen)
  else PaintBar(clRed);
  
  /////////////////////
  // Desenha no gráfico
  Plot(Close);
end;