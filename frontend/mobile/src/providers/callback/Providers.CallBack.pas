unit Providers.CallBack;

interface

uses Data.DB;

type
  TCallBackIdentify = reference to procedure(const AKey: string);
  TCallBackDataSet = reference to procedure(const ADataSet: TDataSet);
  TCallBackInput = reference to procedure(const AResponse: string);

implementation

end.
