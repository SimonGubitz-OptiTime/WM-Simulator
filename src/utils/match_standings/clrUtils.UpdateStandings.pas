unit clrUtils.UpdateStandings;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrState;



procedure GetUpdatedStandings(AState: IState; ASpiel: TSpiel; out AOut1: TTeamStatistik; out AOut2: TTeamStatistik);


implementation

procedure GetUpdatedStandings(AState: IState; ASpiel: TSpiel; out AOut1: TTeamStatistik; out AOut2: TTeamStatistik);
var
  HasStand: Boolean;
begin
  AOut1 := Default(TTeamStatistik);
  AOut2 := Default(TTeamStatistik);

  HasStand := AState.GetTeamStand.ContainsKey(ASpiel.Team1.ID);
  if ( HasStand ) then
  begin
    AOut1 := AState.ForceGetTeamStandByID(ASpiel.Team1.ID);
  end;

  HasStand := AState.GetTeamStand.ContainsKey(ASpiel.Team2.ID);
  if ( HasStand ) then
  begin
    AOut2 := AState.ForceGetTeamStandByID(ASpiel.Team2.ID);
  end;

  if ( ASpiel.Team1Tore = ASpiel.Team2Tore ) then
  begin
    AOut1.Punkte := AOut1.Punkte + 1; // unentschieden + 1
    AOut2.Punkte := AOut2.Punkte + 1; // unentschieden + 1

    AOut1.ToreGeschossen := AOut1.ToreGeschossen + ASpiel.Team1Tore;
    AOut2.ToreGeschossen := AOut2.ToreGeschossen + ASpiel.Team2Tore;
    AOut1.ToreKassiert := AOut1.ToreKassiert + ASpiel.Team2Tore;
    AOut2.ToreKassiert := AOut2.ToreKassiert + ASpiel.Team1Tore;

    AOut1.Unentschieden := AOut1.Unentschieden + 1;
    AOut2.Unentschieden := AOut2.Unentschieden + 1;
  end
  else if ( ASpiel.Team1Tore > ASpiel.Team2Tore ) then
  begin
    AOut1.Punkte := AOut1.Punkte + 3; // gewonnen + 3

    AOut1.ToreGeschossen := AOut1.ToreGeschossen + ASpiel.Team1Tore;
    AOut2.ToreGeschossen := AOut2.ToreGeschossen + ASpiel.Team2Tore;
    AOut1.ToreKassiert := AOut1.ToreKassiert + ASpiel.Team2Tore;
    AOut2.ToreKassiert := AOut2.ToreKassiert + ASpiel.Team1Tore;

    AOut1.Siege := AOut1.Siege + 1;
    AOut2.Niederlagen := AOut2.Niederlagen + 1;
  end
  else if ( ASpiel.Team1Tore < ASpiel.Team2Tore ) then
  begin
    AOut2.Punkte := AOut2.Punkte + 3; // gewonnen + 3

    AOut1.ToreGeschossen := AOut1.ToreGeschossen + ASpiel.Team1Tore;
    AOut2.ToreGeschossen := AOut2.ToreGeschossen + ASpiel.Team2Tore;
    AOut1.ToreKassiert := AOut1.ToreKassiert + ASpiel.Team2Tore;
    AOut2.ToreKassiert := AOut2.ToreKassiert + ASpiel.Team1Tore;

    AOut2.Siege := AOut2.Siege + 1;
    AOut1.Niederlagen := AOut1.Niederlagen + 1;
  end;
end;

end.
