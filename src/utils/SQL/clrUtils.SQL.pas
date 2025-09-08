unit clrUtils.SQL;


interface

type
  TSQLUtils<T> = class
    public
      // TODO: String -> SQLRow whatever type that returns in the OptiTime thing
      class function SQLRowToString(SQLRow: String);
    private
  end;