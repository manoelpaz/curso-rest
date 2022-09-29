unit Providers.Request.Intf;

interface

uses
  System.Classes, System.JSON, RestRequest4D;

type
  IRequest = interface
    ['{B1D93CE4-F4A3-4E90-84A5-02F4CE68CB87}']
    function BaseURL(const AValue: string): IRequest;
    function Resource(const AValue: string): IRequest;
    function ResourceSuffix(const AValue: string): IRequest;
    function AddParam(const AKey, AValue: string): IRequest;
    function ContentType(const AValue: string): IRequest;
    function ClearBody: IRequest;
    function ClearParams: IRequest;
    function AddBody(const ABody: TJSONObject; const AOwns: Boolean = True): IRequest; overload;
    function AddBody(const ABody: TMemoryStream; const AOwns: Boolean = True): IRequest; overload;
    function Get: IResponse;
    function Post: IResponse;
    function Delete: IResponse;
    function Put: IResponse;
  end;

implementation

end.
