unit clrDB;

interface

uses
  damTypes,
  clrUtils.DB,
  clrUtils.CSV,
  clrUtils.RTTI,
  System.Generics.Collections, System.Classes, System.SysUtils, System.IOUtils,
  System.RTTI, Vcl.Dialogs;

type
  TDBUpdateEvent = procedure of object;
  TDBFinderFunction<T> = reference to function(Param: T): Boolean;

  IDB<T: record> = interface
    ['{14e3dfdb-2111-4f24-9a1e-eca451b36d29}']

      function    StrukturierteTabelleErhalten(): TList<T>;
      function    UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;

      procedure   AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);

      procedure   ZeileHinzufuegen(ARowValues: T);
      procedure   ZeileEntfernen(ARow: T);
      function    ZeileFinden(AFinderFunction: TDBFinderFunction<T>; out ReturnValue: T): Boolean;

      function    GetInitialisiert: Boolean;

      property Initialisiert: Boolean read GetInitialisiert;
  end;

implementation

end.
