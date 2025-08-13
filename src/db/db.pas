unit DB;

interface

uses
    SysUtils;



function GetProperty<T>(Table: String): T;
function SetProperty<T>(Table: String): T;
function GetStructuredTable<T>(Table: String): T;
function SetStructuredTable<T>(Table: String): T;


implementation


function GetProperty<T>(Table: String): T;
begin

    // .csv öffnen

end;

end.