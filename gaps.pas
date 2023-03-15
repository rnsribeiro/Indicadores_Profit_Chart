///////////////////////////////////////////////////////////////////
//                               Gaps                            // 
///////////////////////////////////////////////////////////////////
begin
  if (High < Low[1]) then
    begin
      ////////////////
      // Baixa
      PaintBar(clRed);
    end
  else if (Low > High[1]) then
    begin
      ////////////////
      // Alta
      PaintBar(clGreen);
    end;
end;
                                  