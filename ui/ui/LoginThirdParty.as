package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SoundApi;
   import d2api.TimeApi;
   import d2components.WebBrowser;
   import d2actions.*;
   import d2hooks.*;
   import flash.utils.*;
   import d2enums.ComponentHookList;
   
   public class LoginThirdParty extends Object
   {
      
      public function LoginThirdParty() {
         super();
      }
      
      private var _jsApi:Object;
      
      private var _timeoutId:uint;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var timeApi:TimeApi;
      
      public var browser:WebBrowser;
      
      public function main(popup:String = null) : void {
         this._jsApi = 
            {
               "loginClassic":this.JS_API_LoginClassic,
               "loginWithTicket":this.JS_API_LoginWithTicket,
               "getLastLogin":this.JS_API_GetLastLogin,
               "setLastLogin":this.JS_API_SetLastLogin,
               "setPort":this.sysApi.setPort,
               "getPort":this.sysApi.getPort,
               "getLaunchArgs":this.sysApi.getLaunchArgs,
               "setBlankLink":this.browser.setBlankLink,
               "getPartnerInfo":this.sysApi["getPartnerInfo"]
            };
         this._timeoutId = setTimeout(this.init,1);
      }
      
      public function init() : void {
         this.sysApi.goToThirdPartyLogin(this.browser);
         this.uiApi.addComponentHook(this.browser,ComponentHookList.ON_DOM_READY);
      }
      
      public function onBrowserDomReady(target:Object) : void {
         this.browser.javascriptCall("ankInit",this._jsApi);
      }
      
      private function JS_API_LoginClassic(login:String, pass:String) : void {
         this.sysApi.sendAction(new LoginValidation(login,pass,true));
      }
      
      private function JS_API_LoginWithTicket(ticket:String, autoSelectServer:Boolean, serverId:uint = 0) : void {
         this.sysApi.sendAction(new LoginValidationWithTicket(ticket,autoSelectServer,serverId));
      }
      
      private function JS_API_GetLastLogin() : String {
         return this.sysApi.getData("LastLogin")?this.sysApi.getData("LastLogin"):"";
      }
      
      private function JS_API_SetLastLogin(login:String) : void {
         this.sysApi.setData("LastLogin",login);
      }
   }
}
