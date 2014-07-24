package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SoundApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.Texture;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2actions.*;
   import d2hooks.*;
   
   public class Popup extends Object
   {
      
      public function Popup() {
         this._aEventIndex = new Array();
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var soundApi:SoundApi;
      
      protected var _aEventIndex:Array;
      
      protected var onCancelFunction:Function = null;
      
      protected var onEnterKey:Function = null;
      
      protected var numberButton:uint;
      
      protected var defaultShortcutFunction:Function;
      
      public var popCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var ctr_buttons:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_content:Label;
      
      public var tx_background:Texture;
      
      public function main(param:Object) : void {
         var btn:ButtonContainer = null;
         var btnTx:Texture = null;
         var btnLbl:Label = null;
         var i:uint = 0;
         var stateChangingProperties:Array = null;
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.tx_background.autoGrid = true;
         this.lbl_content.textfield.multiline = true;
         this.lbl_content.wordWrap = true;
         var noButton:Boolean = param.hasOwnProperty("noButton");
         if(param)
         {
            if(param.hideModalContainer)
            {
               this.popCtr.getUi().showModalContainer = false;
            }
            else
            {
               this.popCtr.getUi().showModalContainer = true;
            }
            this.lbl_title.text = param.title;
            if(param.noHtml)
            {
               this.lbl_content.html = false;
            }
            else if(param.useHyperLink)
            {
               this.lbl_content.hyperlinkEnabled = true;
               this.lbl_content.useStyleSheet = true;
            }
            
            this.lbl_content.text = param.content;
            if((!noButton) && ((!param.buttonText) || (!param.buttonText.length)))
            {
               throw new Error("Can\'t create popup without any button");
            }
            else
            {
               btnWidth = 150;
               btnHeight = 32;
               padding = 20;
               this.popCtr.height = Math.floor(this.lbl_content.textfield.textHeight) + 150;
               if(!noButton)
               {
                  this.numberButton = param.buttonText.length;
                  if((this.numberButton == 1) && (param.buttonCallback) && (param.buttonCallback.length == 1))
                  {
                     this.defaultShortcutFunction = param.buttonCallback[0];
                  }
                  i = 0;
                  while(i < this.numberButton)
                  {
                     btn = this.uiApi.createContainer("ButtonContainer") as ButtonContainer;
                     if(i == 0)
                     {
                        btn.soundId = SoundEnum.POPUP_YES;
                     }
                     else
                     {
                        btn.soundId = SoundEnum.POPUP_NO;
                     }
                     btn.width = btnWidth;
                     btn.height = btnHeight;
                     btn.x = i * (padding + btnWidth);
                     btn.name = "btn" + (i + 1);
                     this.uiApi.me().registerId(btn.name,this.uiApi.createContainer("GraphicElement",btn,new Array(),btn.name));
                     btnTx = this.uiApi.createComponent("Texture") as Texture;
                     btnTx.width = btnWidth;
                     btnTx.height = btnHeight;
                     btnTx.uri = this.uiApi.createUri(this.uiApi.me().getConstant("btn.file"));
                     btnTx.autoGrid = true;
                     btnTx.name = btn.name + "_tx";
                     this.uiApi.me().registerId(btnTx.name,this.uiApi.createContainer("GraphicElement",btnTx,new Array(),btnTx.name));
                     btnTx.finalize();
                     btnLbl = this.uiApi.createComponent("Label") as Label;
                     btnLbl.width = btnWidth;
                     btnLbl.height = btnHeight;
                     btnLbl.verticalAlign = "center";
                     btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("btn.css"));
                     btnLbl.text = this.uiApi.replaceKey(param.buttonText[i]);
                     btn.addChild(btnTx);
                     btn.addChild(btnLbl);
                     stateChangingProperties = new Array();
                     stateChangingProperties[1] = new Array();
                     stateChangingProperties[1][btnTx.name] = new Array();
                     stateChangingProperties[1][btnTx.name]["gotoAndStop"] = "over";
                     stateChangingProperties[2] = new Array();
                     stateChangingProperties[2][btnTx.name] = new Array();
                     stateChangingProperties[2][btnTx.name]["gotoAndStop"] = "pressed";
                     btn.changingStateData = stateChangingProperties;
                     if((param.buttonCallback) && (param.buttonCallback[i]))
                     {
                        this._aEventIndex[btn.name] = param.buttonCallback[i];
                     }
                     this.uiApi.addComponentHook(btn,"onRelease");
                     this.ctr_buttons.addChild(btn);
                     i++;
                  }
                  if(param.onCancel)
                  {
                     this.onCancelFunction = param.onCancel;
                  }
                  if(param.onEnterKey)
                  {
                     this.onEnterKey = param.onEnterKey;
                  }
               }
               else
               {
                  this.btn_close.visible = false;
                  this.popCtr.height = this.popCtr.height - (btnHeight + padding);
               }
               this.uiApi.me().render();
               return;
            }
         }
         else
         {
            throw new Error("Can\'t load popup without properties.");
         }
      }
      
      public function onRelease(target:Object) : void {
         if(this._aEventIndex[target.name])
         {
            this._aEventIndex[target.name].apply(null);
         }
         else if((target == this.btn_close) && (!(this.onCancelFunction == null)))
         {
            this.onCancelFunction();
         }
         
         if((this.uiApi) && (this.uiApi.me()) && (this.uiApi.getUi(this.uiApi.me().name)))
         {
            this.closeMe();
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               if(this.onEnterKey != null)
               {
                  this.onEnterKey();
               }
               else if(this.defaultShortcutFunction != null)
               {
                  this.defaultShortcutFunction();
               }
               
               this.closeMe();
               return true;
            case "closeUi":
               if(this.onCancelFunction != null)
               {
                  this.onCancelFunction();
               }
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      public function unload() : void {
         this.sysApi.dispatchHook(ClosePopup);
      }
      
      private function closeMe() : void {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
   }
}
