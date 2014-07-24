package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SoundApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Input;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.ShortcutHookListEnum;
   
   public class InputPopup extends Object
   {
      
      public function InputPopup() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var soundApi:SoundApi;
      
      private var _validCallBack:Function;
      
      private var _cancelCallback:Function;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_description:Label;
      
      public var lbl_input:Input;
      
      public var btn_close:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public function main(param:Object) : void {
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_ok.soundId = SoundEnum.OK_BUTTON;
         this.lbl_title.text = param.title;
         this.lbl_description.text = param.content;
         this.lbl_input.text = param.defaultValue;
         this.lbl_input.selectAll();
         this._validCallBack = param.validCallBack;
         this._cancelCallback = param.cancelCallback;
         this.lbl_input.restrictChars = param.restric;
         this.lbl_input.maxChars = param.maxChars;
         this.lbl_input.focus();
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_ok)
         {
            if(this._validCallBack != null)
            {
               this._validCallBack(this.lbl_input.text);
            }
         }
         else if(target == this.btn_close)
         {
            if(this._cancelCallback != null)
            {
               this._cancelCallback();
            }
         }
         
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onShortcut(s:String) : Boolean {
         if(this.lbl_input == null)
         {
            return true;
         }
         switch(s)
         {
            case ShortcutHookListEnum.VALID_UI:
               if(this._validCallBack != null)
               {
                  this._validCallBack(this.lbl_input.text);
               }
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case ShortcutHookListEnum.CLOSE_UI:
               this.onRelease(this.btn_close);
               return true;
         }
         return false;
      }
      
      public function unload() : void {
         this.sysApi.dispatchHook(ClosePopup);
      }
   }
}
