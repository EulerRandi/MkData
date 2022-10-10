unit ViaCEP.Intf;

interface

uses ViaCEP.Model;

type
  IViaCEP = interface
    ['{202D4AB9-6B89-4CFF-A080-9DBC09D66737}']
    function Get(const ACep: string): TViaCEPClass;
    function Validate(const ACep: string): Boolean;
  end;

implementation

end.
