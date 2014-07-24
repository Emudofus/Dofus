package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.BindsApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.TextArea;
   import d2components.Texture;
   import d2components.Label;
   import d2actions.*;
   import d2hooks.*;
   import flash.ui.Keyboard;
   
   public class PasswordMenu extends Object
   {
      
      public function PasswordMenu() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var bindsApi:BindsApi;
      
      private var _size:int;
      
      private var _changeOrUse:Boolean;
      
      private var _numberList:Array;
      
      private var _index:int;
      
      private var _listPosX:Array;
      
      private var _txList:Array;
      
      private var _lblList:Array;
      
      private var _bgList:Array;
      
      private var _onCancel:Function;
      
      private var _onConfirm:Function;
      
      private var _onClose:Function;
      
      public var mainCtr:GraphicContainer;
      
      public var grid:Object;
      
      public var btnOk:ButtonContainer;
      
      public var btnClose:ButtonContainer;
      
      public var btnReset:ButtonContainer;
      
      public var orangeBox:GraphicContainer;
      
      public var lblInfo:TextArea;
      
      public var btn0:ButtonContainer;
      
      public var btn1:ButtonContainer;
      
      public var btn2:ButtonContainer;
      
      public var btn3:ButtonContainer;
      
      public var btn4:ButtonContainer;
      
      public var btn5:ButtonContainer;
      
      public var btn6:ButtonContainer;
      
      public var btn7:ButtonContainer;
      
      public var btn8:ButtonContainer;
      
      public var btn9:ButtonContainer;
      
      public var txBtn0:Texture;
      
      public var txBtn1:Texture;
      
      public var txBtn2:Texture;
      
      public var txBtn3:Texture;
      
      public var txBtn4:Texture;
      
      public var txBtn5:Texture;
      
      public var txBtn6:Texture;
      
      public var txBtn7:Texture;
      
      public var textBtn0:Label;
      
      public var textBtn1:Label;
      
      public var textBtn2:Label;
      
      public var textBtn3:Label;
      
      public var textBtn4:Label;
      
      public var textBtn5:Label;
      
      public var textBtn6:Label;
      
      public var textBtn7:Label;
      
      public var bgBtn0:Texture;
      
      public var bgBtn1:Texture;
      
      public var bgBtn2:Texture;
      
      public var bgBtn3:Texture;
      
      public var bgBtn4:Texture;
      
      public var bgBtn5:Texture;
      
      public var bgBtn6:Texture;
      
      public var bgBtn7:Texture;
      
      public function main(param:Object) : void {
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._size = param.size;
         this._changeOrUse = param.changeOrUse;
         this._onCancel = param.cancelCallBack;
         this._onConfirm = param.confirmCallBack;
         this.lblInfo.wordWrap = true;
         if(this._changeOrUse)
         {
            this.lblInfo.text = this.uiApi.getText("ui.common.lockInfos");
         }
         else
         {
            this.lblInfo.text = this.uiApi.getText("ui.common.unlockInfos");
         }
         this._txList = new Array(this.txBtn0,this.txBtn1,this.txBtn2,this.txBtn3,this.txBtn4,this.txBtn5,this.txBtn6,this.txBtn7);
         this._lblList = new Array(this.textBtn0,this.textBtn1,this.textBtn2,this.textBtn3,this.textBtn4,this.textBtn5,this.textBtn6,this.textBtn7);
         this._bgList = new Array(this.bgBtn0,this.bgBtn1,this.bgBtn2,this.bgBtn3,this.bgBtn4,this.bgBtn5,this.bgBtn6,this.bgBtn7);
         this._listPosX = new Array(8);
         var t:int = 0;
         while(t < 8)
         {
            this._listPosX[t] = this._txList[t].x - 2;
            t++;
         }
         this.reset();
         this.bindsApi.enableShortcutKey(Keyboard.SPACE,32,false);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.sysApi.addHook(LeaveDialog,this.onLeaveDialog);
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnOk,"onRelease");
         this.uiApi.addComponentHook(this.btnReset,"onRelease");
         this.uiApi.addComponentHook(this.btn0,"onRelease");
         this.uiApi.addComponentHook(this.btn1,"onRelease");
         this.uiApi.addComponentHook(this.btn2,"onRelease");
         this.uiApi.addComponentHook(this.btn3,"onRelease");
         this.uiApi.addComponentHook(this.btn4,"onRelease");
         this.uiApi.addComponentHook(this.btn5,"onRelease");
         this.uiApi.addComponentHook(this.btn6,"onRelease");
         this.uiApi.addComponentHook(this.btn7,"onRelease");
         this.uiApi.addComponentHook(this.btn8,"onRelease");
         this.uiApi.addComponentHook(this.btn9,"onRelease");
         this.sysApi.disableWorldInteraction();
      }
      
      public function getCode() : String {
         var number:* = 0;
         var code:String = "";
         var i:int = 0;
         while(i < 8)
         {
            if(i >= this._size)
            {
               code = code + "_";
            }
            else
            {
               number = this._numberList[i];
               if(number != -1)
               {
                  if(number == 10)
                  {
                     code = code + "_";
                  }
                  else
                  {
                     code = code + number;
                  }
               }
               else
               {
                  code = code + "_";
               }
            }
            i++;
         }
         return code;
      }
      
      public function unload() : void {
         this.bindsApi.enableShortcutKey(Keyboard.SPACE,32,true);
         this.sysApi.enableWorldInteraction();
      }
      
      private function addNumber(number:int) : void {
         this._numberList[this._index] = number;
         this._index++;
         if(this._index >= this._size)
         {
            this._index = 0;
         }
         this.updateNumbers();
      }
      
      private function reset() : void {
         this._numberList = new Array(this._size);
         var i:int = 0;
         while(i < this._size)
         {
            this._numberList[i] = -1;
            i++;
         }
         this._index = 0;
         this.orangeBox.y = 76;
         this.updateNumbers();
      }
      
      private function updateNumbers() : void {
         var number:* = 0;
         var label:Object = null;
         var i:int = 0;
         while(i < this._size)
         {
            number = this._numberList[i];
            if((number == -1) || (number == 10))
            {
               this._txList[i].visible = false;
               this._lblList[i].visible = false;
            }
            else
            {
               this._txList[i].visible = true;
               label = this._lblList[i];
               label.visible = true;
               label.text = String(this._numberList[i]);
            }
            i++;
         }
         var k:int = i;
         while(k < 8)
         {
            this._txList[k].visible = false;
            this._lblList[k].visible = false;
            this._bgList[k].visible = false;
            k++;
         }
         this.orangeBox.x = this._listPosX[this._index];
      }
      
      public function onRelease(target:Object) : void {
         switch(true)
         {
            case target == this.btnReset:
               this.reset();
               return;
            case target == this.btnClose:
               this.uiApi.unloadUi("passwordMenu");
               if(this._onCancel != null)
               {
                  this._onCancel();
               }
               return;
            case target == this.btnOk:
               this.uiApi.unloadUi("passwordMenu");
               this._onConfirm(this._changeOrUse,this.getCode());
               return;
            case target == this.btn0:
               this.addNumber(0);
               return;
            case target == this.btn1:
               this.addNumber(1);
               return;
            case target == this.btn2:
               this.addNumber(2);
               return;
            case target == this.btn3:
               this.addNumber(3);
               return;
            case target == this.btn4:
               this.addNumber(4);
               return;
            case target == this.btn5:
               this.addNumber(5);
               return;
            case target == this.btn6:
               this.addNumber(6);
               return;
            case target == this.btn7:
               this.addNumber(7);
               return;
            case target == this.btn8:
               this.addNumber(8);
               return;
            case target == this.btn9:
               this.addNumber(9);
               return;
            default:
               return;
         }
      }
      
      private function onKeyUp(target:Object, keyCode:int) : void {
         switch(true)
         {
            case keyCode == Keyboard.SPACE:
               this.addNumber(10);
               return;
         }
      }
      
      private function onLeaveDialog() : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               this.uiApi.unloadUi("passwordMenu");
               this._onConfirm(this._changeOrUse,this.getCode());
               return true;
            case "closeUi":
               this.uiApi.unloadUi("passwordMenu");
               if(this._onCancel != null)
               {
                  this._onCancel();
               }
               return true;
            default:
               return false;
         }
      }
   }
}
