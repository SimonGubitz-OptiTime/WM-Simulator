unit Utils.Routing;


interface

uses
    Vcl.Dialogs;

function OnStammdatenChanging(Condition: Boolean): Boolean;
function OnVerlosungChanging(Condition: Boolean): Boolean;
function OnSpielplanChanging(Condition: Boolean): Boolean;
function OnSpielChanging(Condition: Boolean): Boolean;

implementation

function OnStammdatenChanging(Condition: Boolean): Boolean;
begin

    // JS equivalent to block default
    

    // Gültigkeitsüberprüfung
    if not Condition then
    begin
        ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
        Exit;
    end
    else
    begin
        // Der Nutzer darf weiter
    end;
end;

function OnVerlosungChanging(Condition: Boolean): Boolean;
begin

    // JS equivalent to block default


    // Gültigkeitsüberprüfung
    if not Condition then
    begin
        ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
        Exit;
    end
    else
    begin
        // Der Nutzer darf weiter
//        MainForm.PageControl.ActivePageIndex := 1;
    end;
end;

function OnSpielplanChanging(Condition: Boolean): Boolean;
begin

    // JS equivalent to block default


    // Gültigkeitsüberprüfung
    if not Condition then
    begin
        ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
        Exit;
    end
    else
    begin
        // Der Nutzer darf weiter
//        MainForm.PageControl.ActivePageIndex := 2;
    end;
end;

function OnSpielChanging(Condition: Boolean): Boolean;
begin

    // JS equivalent to block default


    // Gültigkeitsüberprüfung
    if not Condition then
    begin
        ShowMessage('Es gibt unvollständige oder falsche Eingaben. Du musst zurück und alles richtig ausfüllen.');
        Exit;
    end
    else
    begin
        // Der Nutzer darf weiter
//        MainForm.PageControl.ActivePageIndex := 3;
    end;
end;




end.
