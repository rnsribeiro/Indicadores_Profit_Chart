///////////////////////////////////////////////////////////////////
//                            Inside Candle                      //
///////////////////////////////////////////////////////////////////
begin
  //////////////////////////////////////////////////////////////
  //Testa os limites do candle e pinta caso for um inside candle
  if (HIGH < HIGH[1]) and (LOW > LOW[1]) then
    PaintBar(clYellow);
end;





                                                            