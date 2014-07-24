package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2components.ButtonContainer;
   import d2components.WebBrowser;
   import d2components.GraphicContainer;
   import d2enums.ShortcutHookListEnum;
   import d2actions.*;
   import d2hooks.*;
   import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
   
   public class WebPortal extends Object
   {
      
      public function WebPortal() {
         super();
      }
      
      private static var _lastDomain:int = -1;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var btnClose:ButtonContainer;
      
      public var btnBigClose:ButtonContainer;
      
      public var browser:WebBrowser;
      
      public var mainCtr:GraphicContainer;
      
      public var bgCtr:GraphicContainer;
      
      public var bigCloseCtr:GraphicContainer;
      
      private var _domain:int = -1;
      
      private var _args:Object;
      
      private var _showBigClose:Boolean;
      
      public function main(arg:*) : void {
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.browser,"onBrowserSessionTimeout");
         this.uiApi.addComponentHook(this.browser,"onBrowserDomReady");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.bgCtr.visible = false;
         this._domain = arg[0];
         this._showBigClose = arg[1];
         _lastDomain = this._domain;
         this._args = arg[2];
         this.refreshPortal();
      }
      
      public function goTo(domain:int, showBigClose:Boolean, args:Array) : void {
         this._domain = domain;
         this._showBigClose = showBigClose;
         _lastDomain = this._domain;
         this._args = args;
         this.refreshPortal();
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btnClose:
            case this.btnBigClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         if(s == "validUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         return true;
      }
      
      public function onBrowserSessionTimeout(target:*) : void {
         this.sysApi.refreshUrl(this.browser,this._domain);
      }
      
      public function onBrowserDomReady(target:*) : void {
      }
      
      public function onAccountInfo(accountId:int) : void {
         if(!this._args)
         {
            this._args = new Array();
         }
         this._args[0] = String(accountId);
         this.refreshPortal();
      }
      
      private function refreshPortal() : void {
         if(this._showBigClose)
         {
            this.bigCloseCtr.visible = true;
         }
         else
         {
            this.bigCloseCtr.visible = false;
         }
         if(this._domain == WebLocationEnum.WEB_LOCATION_OGRINE)
         {
            this.sysApi.goToOgrinePortal(this.browser);
         }
         else if(this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX)
         {
            this.sysApi.goToAnkaBoxPortal(this.browser);
         }
         else if(this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_LAST_UNREAD)
         {
            this.sysApi.goToAnkaBoxLastMessage(this.browser);
         }
         else if(this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE)
         {
            if((this._args) && (this._args[0]))
            {
               this.sysApi.goToAnkaBoxSend(this.browser,int(this._args[0]));
            }
         }
         
         
         
      }
   }
}
