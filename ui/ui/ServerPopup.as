package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SoundApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2hooks.*;
   import d2actions.*;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   
   public class ServerPopup extends Object
   {
      
      public function ServerPopup() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var soundApi:SoundApi;
      
      private var _selectedServer:Object;
      
      public var ctr_content:GraphicContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var btn_undo:ButtonContainer;
      
      public function main(params:Object) : void {
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._selectedServer = params[0];
         this.uiApi.loadUiInside("serverForm",this.ctr_content,"serverForm",{"server":this._selectedServer});
      }
      
      public function unload() : void {
         this.uiApi.unloadUi("serverForm");
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_ok:
               this.onValidateServer();
               break;
            case this.btn_undo:
               if(this.uiApi.getUi("serverSimpleSelection"))
               {
                  this.uiApi.getUi("serverSimpleSelection").uiClass.onSelectedServerRefused(0,"",null);
               }
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               this.onValidateServer();
               return true;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onValidateServer() : void {
         this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
         this.btn_ok.disabled = true;
         this.btn_undo.disabled = true;
         this.sysApi.sendAction(new d2actions.ServerSelection(this._selectedServer.id));
         if(this.uiApi.getUi("serverSimpleSelection"))
         {
            this.uiApi.unloadUi("serverSimpleSelection");
         }
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
