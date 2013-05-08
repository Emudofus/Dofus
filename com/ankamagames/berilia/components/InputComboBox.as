package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import flash.ui.Keyboard;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.handlers.FocusHandler;


   public class InputComboBox extends ComboBox implements FinalizableUIComponent
   {
         

      public function InputComboBox() {
         super();
         _mainContainer=new Input();
         _dataNameField="";
      }



      private var FilteredDataProvider;

      private var origDataProvider;

      public function get input() : Input {
         if(!_mainContainer)
         {
            return null;
         }
         return _mainContainer as Input;
      }

      public function set maxChars(nValue:uint) : void {
         (_mainContainer as Input).maxChars=nValue;
      }

      public function set restrictChars(sValue:String) : void {
         (_mainContainer as Input).restrictChars=sValue;
      }

      public function get restrictChars() : String {
         return (_mainContainer as Input).restrictChars;
      }

      public function set cssClass(c:String) : void {
         (_mainContainer as Input).cssClass=c;
      }

      public function get cssClass() : String {
         return (_mainContainer as Input).cssClass;
      }

      public function get css() : Uri {
         return (_mainContainer as Input).css;
      }

      public function set css(sFile:Uri) : void {
         (_mainContainer as Input).css=sFile;
      }

      override public function get dataProvider() : * {
         return _list.dataProvider;
      }

      override public function set dataProvider(data:*) : void {
         this.origDataProvider=data;
         super.dataProvider=data;
      }

      override public function finalize() : void {
         _button.width=width;
         _button.height=height;
         _bgTexture.width=width;
         _bgTexture.height=height;
         _bgTexture.autoGrid=true;
         _bgTexture.finalize();
         _button.addChild(_bgTexture);
         getUi().registerId(_bgTexture.name,new GraphicElement(_bgTexture,new Array(),_bgTexture.name));
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER]=new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][_mainContainer.name]=new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][_mainContainer.name]["gotoAndStop"]=StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_CLICKED]=new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][_mainContainer.name]=new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][_mainContainer.name]["gotoAndStop"]=StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         _button.changingStateData=stateChangingProperties;
         _button.finalize();
         _list.width=width-listSizeOffset;
         _list.width=width-listSizeOffset;
         _list.slotWidth=_list.width;
         _list.slotHeight=height-4;
         _list.x=2;
         _list.y=height+2;
         _list.finalize();
         _listTexture.width=_list.width+4;
         _listTexture.autoGrid=true;
         _listTexture.y=height-2;
         _listTexture.finalize();
         addChild(_button);
         addChild(_listTexture);
         addChild(_list);
         _listTexture.mouseEnabled=false;
         _list.mouseEnabled=false;
         _mainContainer.x=_list.x;
         _mainContainer.width=_list.width;
         _mainContainer.height=height;
         if(autoCenter)
         {
            _mainContainer.y=(height-_mainContainer.height)/2;
         }
         addChild(_mainContainer);
         _finalized=true;
         getUi().iAmFinalized(this);
      }

      override public function process(msg:Message) : Boolean {
         var keyCode:uint = 0;
         var index:* = undefined;
         var input:Input = null;
         switch(true)
         {
            case msg is KeyboardKeyUpMessage:
               keyCode=KeyboardMessage(msg).keyboardEvent.keyCode;
               if(keyCode==Keyboard.ENTER)
               {
                  if(_list.visible)
                  {
                     index=_list.selectedIndex;
                     _list.setSelectedIndex(index,SelectMethodEnum.AUTO);
                     input=Input(_mainContainer);
                     input.text=_list.selectedItem;
                     input.setSelection(input.text.length,input.text.length);
                     this.showList(false);
                     return true;
                  }
               }
               else
               {
                  this.searchStringInCB(Input(_mainContainer).text);
               }
               break;
            case msg is SelectItemMessage:
               switch(SelectItemMessage(msg).selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     _list.renderer.update(_list.selectedItem,0,_mainContainer,false);
                     break;
                  case SelectMethodEnum.UP_ARROW:
                  case SelectMethodEnum.DOWN_ARROW:
                  case SelectMethodEnum.RIGHT_ARROW:
                  case SelectMethodEnum.LEFT_ARROW:
                  case SelectMethodEnum.SEARCH:
                  case SelectMethodEnum.AUTO:
                  case SelectMethodEnum.MANUAL:
                     break;
                  default:
                     this.showList(false);
               }
               break;
            default:
               super.process(msg);
         }
         return false;
      }

      override protected function showList(show:Boolean) : void {
         _list.dataProvider=this.origDataProvider;
         super.showList(show);
      }

      override protected function searchStringInCB(searchPhrase:String, startIndex:int=0) : void {
         var cleanphrase:String = null;
         var newDtp:Vector.<String> = null;
         var label:String = null;
         if(FocusHandler.getInstance().getFocus()==Input(_mainContainer).textfield)
         {
            cleanphrase=this.cleanString(searchPhrase);
            if(cleanphrase!="")
            {
               newDtp=new Vector.<String>();
               for each (label in this.origDataProvider)
               {
                  if(label.indexOf(cleanphrase)==0)
                  {
                     newDtp.push(label);
                  }
               }
               super.dataProvider=newDtp;
            }
            else
            {
               if(searchPhrase!="\b")
               {
                  super.dataProvider=this.origDataProvider;
               }
            }
         }
      }

      override protected function cleanString(spaced:String) : String {
         var unwantedChar:RegExp = new RegExp("\b","g");
         if(spaced.search(unwantedChar)!=-1)
         {
            return "";
         }
         return spaced;
      }
   }

}