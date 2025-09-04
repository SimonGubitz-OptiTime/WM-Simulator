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

  IDB<T: record> = interface
    ['{14e3dfdb-2111-4f24-9a1e-eca451b36d29}']

      procedure   ZeileHinzufuegen(ARowValues: T);
      function    StrukturierteTabelleErhalten(): TList<T>;
      function    UnstrukturierteTabelleErhalten(): TObjectList<TList<String>>;
      procedure   AddDBUpdateEventListener(ACallbackFunction: TDBUpdateEvent);


      function GetInitialisiert: Boolean;

      property Initialisiert: Boolean read GetInitialisiert;
  end;

implementation


end.
