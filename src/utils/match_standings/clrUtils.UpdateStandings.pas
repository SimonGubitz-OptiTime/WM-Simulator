unit clrUtils.UpdateStandings;

interface

uses
  System.Generics.Collections,
  damTypes,
  clrState;



procedure UpdatedStandings(AState: TWMState; Team1Tore, Team2Tore, Team1ID, Team2ID: Integer; out AOut1: TTeamStatistik; out AOut2: TTeamStatistik);


implementation

procedure UpdatedStandings(AState: TWMState; Team1Tore, Team2Tore, Team1ID, Team2ID: Integer; out AOut1: TTeamStatistik; out AOut2: TTeamStatistik);
var
  HasStand: Boolean;
begin
  AOut1 := Default(TTeamStatistik);
  AOut2 := Default(TTeamStatistik); 

  HasStand := AState.GetTeamStand.ContainsKey(Team1ID);
  if ( HasStand ) then
  begin
    AOut1 := AState.ForceGetTeamStandByID(Team1ID);
  end;

  HasStand := AState.GetTeamStand.ContainsKey(Team2ID);
  if ( HasStand ) then
  begin
    AOut2 := AState.ForceGetTeamStandByID(Team2ID);
  end;

  if ( Team1Tore = Team2Tore ) then
  begin
    AOut1.Punkte := AOut1.Punkte + 1; // unentschieden + 1
    AOut2.Punkte := AOut2.Punkte + 1; // unentschieden + 1

    AOut1.ToreGeschossen := AOut1.ToreGeschossen + Team1Tore;
    AOut2.ToreGeschossen := AOut2.ToreGeschossen + Team2Tore;
    AOut1.ToreKassiert := AOut1.ToreKassiert + Team2Tore;
    AOut2.ToreKassiert := AOut2.ToreKassiert + Team1Tore;

    AOut1.Unentschieden := AOut1.Unentschieden + 1;
    AOut2.Unentschieden := AOut2.Unentschieden + 1;
  end
  else if ( Team1Tore > Team2Tore ) then
  begin
    AOut1.Punkte := AOut1.Punkte + 3; // gewonnen + 3

    AOut1.ToreGeschossen := AOut1.ToreGeschossen + Team1Tore;
    AOut2.ToreGeschossen := AOut2.ToreGeschossen + Team2Tore;
    AOut1.ToreKassiert := AOut1.ToreKassiert + Team2Tore;
    AOut2.ToreKassiert := AOut2.ToreKassiert + Team1Tore;

    AOut1.Siege := AOut1.Siege + 1;
    AOut2.Niederlagen := AOut2.Niederlagen + 1;
  end
  else if ( Team1Tore < Team2Tore ) then
  begin
    AOut2.Punkte := AOut2.Punkte + 3; // gewonnen + 3

    AOut1.ToreGeschossen := AOut1.ToreGeschossen + Team1Tore;
    AOut2.ToreGeschossen := AOut2.ToreGeschossen + Team2Tore;
    AOut1.ToreKassiert := AOut1.ToreKassiert + Team2Tore;
    AOut2.ToreKassiert := AOut2.ToreKassiert + Team1Tore;

    AOut2.Siege := AOut2.Siege + 1;
    AOut1.Niederlagen := AOut1.Niederlagen + 1;
  end;
end;

end.
