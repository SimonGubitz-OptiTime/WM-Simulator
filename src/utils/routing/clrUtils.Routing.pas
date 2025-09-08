unit clrUtils.Routing;

interface

uses
  Vcl.Dialogs;

function OnStammdatenChanging(ACondtion: Boolean): Boolean;
function OnVerlosungChanging(ACondtion: Boolean): Boolean;
function OnGruppenphaseChanging(ACondtion: Boolean): Boolean;
function OnSpielChanging(ACondtion: Boolean): Boolean;

implementation

function OnStammdatenChanging(ACondtion: Boolean): Boolean;
begin

  // JS equivalent to block default

  // Gültigkeitsüberprüfung
  {if not ( ACondition ) then
    begin
      ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
      Exit;
    end
    else
    begin
      // Der Nutzer darf weiter
    end;}
end;

function OnVerlosungChanging(ACondtion: Boolean): Boolean;
begin

  // JS equivalent to block default

  // Gültigkeitsüberprüfung
  {if not ( ACondition ) then
  begin
    ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
    Exit;
  end
  else
  begin
    // Der Nutzer darf weiter
    // MainForm.PageControl.ActivePageIndex := 1;
  end;}
end;

function OnGruppenphaseChanging(ACondtion: Boolean): Boolean;
begin

  // JS equivalent to block default

  // Gültigkeitsüberprüfung
  {if not ( ACondition ) then
  begin
    ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
    Exit;
  end
  else
  begin
    // Der Nutzer darf weiter
    // MainForm.PageControl.ActivePageIndex := 2;
  end;}
end;

function OnSpielChanging(ACondtion: Boolean): Boolean;
begin

  // JS equivalent to block default

  // Gültigkeitsüberprüfung
  {if not ( ACondition ) then
    begin
      ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
      Exit;
    end
    else
    begin
      // Der Nutzer darf weiter
      // MainForm.PageControl.ActivePageIndex := 3;
    end;}
end;

end.
