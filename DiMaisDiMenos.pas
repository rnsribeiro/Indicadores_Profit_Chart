///////////////////////////////////////////////////////////////////
//                               DI+/DI-                         //  
///////////////////////////////////////////////////////////////////
input
  nPeriod(14);
var
  sWTR      : Float;   
  sWPlusDM  : Float;
  sWMinusDM : Float;
  sPlusDi   : Float;
  sMinusDi  : Float; 
  nIndex    : Integer; 

///////////////////////////////////////////////////////////////////
//                               CalcPlusDM                      //
///////////////////////////////////////////////////////////////////
function CalcPlusDM : Float;
var
  sHiDiff : Float;
  sLoDiff : Float;
begin
  //////////////////////////
  //calcula o valor de DM+
  sHiDiff := HIGH - HIGH[1];
  sLoDiff := LOW[1] - LOW;
  if ((sHiDiff < 0) and (sLoDiff < 0)) or (sHiDiff <= sLoDiff)
    then Result := 0
    else Result := sHiDiff; 
end;

////////////////////////////////////////////////////////////////////
//                               CalcMinusDM                      //
////////////////////////////////////////////////////////////////////
function CalcMinusDM : Float;
var
  sHiDiff : Float;
  sLoDiff : Float;
begin
  //////////////////////////
  //calcula o valor de DM-
  sHiDiff := HIGH - HIGH[1];
  sLoDiff := LOW[1] - LOW;
  if ((sHiDiff < 0) and (sLoDiff < 0)) or (sHiDiff >= sLoDiff)
    then Result := 0
    else Result := sLoDiff;    
end;

////////////////////////////////////////////////////////////////////
//                                  Main                          //
////////////////////////////////////////////////////////////////////
begin
  if (CurrentBar > 0) and (CurrentBar < nPeriod) then
    begin
      //////////////////////////////
      //Calcula os valores iniciais
      sWPlusDM  := CalcPlusDM;
      sWMinusDM := CalcMinusDM;
      sWTR      := TrueRange;
    end   
  else if CurrentBar >= nPeriod then
    begin
      ///////////////////////////////////////////
      //Executa as funções que calculam DM+ e DM-
      sWPlusDM  := CalcPlusDM;
      sWMinusDM := CalcMinusDM;

      ////////////////////////////////////////
      //Executa a estratégia que calcula o TR
      sWTR      := TrueRange;

      //////////////////////////////////////////////////////////////
      //Executa o Welles Summation sobre os valores de DM+, DM- e TR
      sWTR      := WellesSum(nPeriod, sWTR     , 1);
      sWPlusDM  := WellesSum(nPeriod, sWPlusDM , 1);
      sWMinusDM := WellesSum(nPeriod, sWMinusDM, 1);

      ///////////////////////////////////
      //Calcula os valores de DI+ e DI-
      sPlusDi   := 100 * (sWPlusDM /sWTR);
      sMinusDi  := 100 * (sWMinusDM/sWTR); 

      /////////////////////////////////////////////
      //Desenha no gráfico os valores de DI+ e DI-
      Plot (sPlusDi);
      Plot2(sMinusDi);
    end;       
end;
