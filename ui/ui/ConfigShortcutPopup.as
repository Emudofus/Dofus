package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.BindsApi;
   import d2api.SoundApi;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.GraphicContainer;
   import d2data.Bind;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2actions.*;
   import d2hooks.*;
   import d2data.Shortcut;
   import flash.ui.Keyboard;
   
   public class ConfigShortcutPopup extends Object
   {
      
      public function ConfigShortcutPopup() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var bindsApi:BindsApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var btnDefault:ButtonContainer;
      
      public var btnCancel:ButtonContainer;
      
      public var btnOk:ButtonContainer;
      
      public var lblTitle:Label;
      
      public var lblDescription:Label;
      
      public var lblShortcut:Label;
      
      public var lblError:Label;
      
      public var btnDelete:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      private var _callback:Function;
      
      private var _actualBind:Bind;
      
      private var _currentBind:Bind;
      
      private var _currentShortcut:Object;
      
      public function main(args:*) : void {
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.btnDefault.soundId = SoundEnum.SPEC_BUTTON;
         this.btnCancel.soundId = SoundEnum.CANCEL_BUTTON;
         this.btnOk.soundId = SoundEnum.OK_BUTTON;
         this.btnDelete.soundId = SoundEnum.DELETE_BUTTON;
         this._callback = args.callback;
         this._currentBind = this._actualBind = args.bind;
         this._currentShortcut = args.shortcut;
         this.lblDescription.text = args.shortcut.description;
         this.lblShortcut.html = false;
         this.lblShortcut.text = (args.bind) && (args.bind.key)?args.bind:this.uiApi.getText("ui.common.none");
         this.uiApi.addComponentHook(this.btnDefault,"onRelease");
         this.uiApi.addComponentHook(this.btnCancel,"onRelease");
         this.uiApi.addComponentHook(this.btnDelete,"onRelease");
         this.uiApi.addComponentHook(this.btnOk,"onRelease");
         this.sysApi.addHook(KeyboardShortcut,this.onKeyboardShortcut);
      }
      
      public function unload() : void {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function onRelease(target:Object) : void {
         var s:Object = null;
         switch(target)
         {
            case this.btnCancel:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btnDelete:
               this.btnOk.disabled = false;
               this.lblError.visible = false;
               this._currentBind = null;
               this.lblShortcut.text = this.uiApi.getText("ui.common.none");
               break;
            case this.btnOk:
               if((!this._actualBind) || (!this._actualBind.equals(this._currentBind)))
               {
                  if((this.bindsApi.bindIsPermanent(this._currentBind)) || (this.lblError.visible))
                  {
                     this.sysApi.log(2,"raccourci bloqué !");
                  }
                  else if(this.bindsApi.bindIsRegister(this._currentBind))
                  {
                     s = this.bindsApi.getShortcutByName(this.bindsApi.getRegisteredBind(this._currentBind).targetedShortcut);
                     if(!s.required)
                     {
                        this.modCommon.openTextPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.config.confirm.shortcut",this._currentBind.toString(),s.description),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onShortcutConfirm,null],this.onShortcutConfirm);
                     }
                     else
                     {
                        this.modCommon.openTextPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.config.shortcut.error.required",this._currentBind.toString(),s.description,s.description,this._currentBind.toString()),[this.uiApi.getText("ui.common.ok")]);
                     }
                  }
                  else
                  {
                     this._callback.apply(null,[this._currentBind]);
                     this.uiApi.unloadUi(this.uiApi.me().name);
                  }
                  
               }
               else
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               break;
            case this.btnDefault:
               this.btnOk.disabled = false;
               this.lblError.visible = false;
               this._currentBind = (this._currentShortcut.defaultBind) && (this._currentShortcut.name == this._currentShortcut.defaultBind.targetedShortcut)?this._currentShortcut.defaultBind:null;
               if(this._currentBind == null)
               {
                  this.lblShortcut.text = this.uiApi.getText("ui.common.none");
               }
               else
               {
                  this.lblShortcut.text = this._currentBind + "";
               }
               break;
         }
      }
      
      private function onKeyboardShortcut(bind:Bind, keyCode:uint) : void {
         this.btnOk.disabled = false;
         this.lblError.visible = false;
         if(this.bindsApi.bindIsPermanent(bind))
         {
            this.lblError.visible = true;
            this.btnOk.disabled = true;
         }
         else if((this._currentShortcut.textfieldEnabled) && (!(this._currentShortcut as Shortcut).defaultBind.equals(bind)) && (!((bind.shift) && (bind.ctrl) || (bind.alt) && (!bind.ctrl) || (bind.ctrl) && (!bind.alt))))
         {
            switch(keyCode)
            {
               case Keyboard.CONTROL:
               case Keyboard.DOWN:
               case Keyboard.ENTER:
               case Keyboard.ESCAPE:
               case Keyboard.F1:
               case Keyboard.F2:
               case Keyboard.F3:
               case Keyboard.F4:
               case Keyboard.F5:
               case Keyboard.F6:
               case Keyboard.F7:
               case Keyboard.F8:
               case Keyboard.F9:
               case Keyboard.F10:
               case Keyboard.F11:
               case Keyboard.F12:
               case Keyboard.F13:
               case Keyboard.F14:
               case Keyboard.F15:
               case Keyboard.LEFT:
               case Keyboard.PAGE_DOWN:
               case Keyboard.PAGE_UP:
               case Keyboard.RIGHT:
                  this._currentBind = bind;
                  break;
               default:
                  this.lblError.visible = true;
                  this.btnOk.disabled = true;
            }
         }
         else
         {
            this._currentBind = bind;
         }
         
         this.lblShortcut.text = bind.toString();
      }
      
      public function onShortcut(s:String) : Boolean {
         return true;
      }
      
      private function onShortcutConfirm() : void {
         this._callback.apply(null,[this._currentBind]);
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
