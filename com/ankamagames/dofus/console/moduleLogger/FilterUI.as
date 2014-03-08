package com.ankamagames.dofus.console.moduleLogger
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.events.Event;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   
   public final class FilterUI extends Sprite
   {
      
      public function FilterUI(backgroundColor:uint) {
         this._excludeList = new Array();
         this._includeList = new Array();
         super();
         this._backgroundColor = backgroundColor;
         this.createUI();
         this._filterList.text = "";
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      private static const TITLE_HEIGHT:int = 20;
      
      public var excludeMode:Boolean = false;
      
      public var isOn:Boolean = true;
      
      private var _excludeText:String = "";
      
      private var _excludeList:Array;
      
      private var _includeText:String = "";
      
      private var _includeList:Array;
      
      private var _backgroundColor:uint;
      
      private var _title:TextField;
      
      private var _filterList:TextField;
      
      public function isFiltered(text:String) : Boolean {
         var num:* = 0;
         var i:* = 0;
         var text:String = text.toLocaleLowerCase();
         if(this.excludeMode)
         {
            return !(this._excludeList.indexOf(text) == -1);
         }
         if(this._includeList.length)
         {
            num = this._includeList.length;
            i = -1;
            while(++i < num)
            {
               if(text.indexOf(this._includeList[i]) != -1)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public function addToFilter(text:String) : void {
         if(this._filterList.text.toLocaleLowerCase().indexOf(text.toLocaleLowerCase()) != -1)
         {
            return;
         }
         if(this._filterList.text)
         {
            this._filterList.appendText("\n" + text);
         }
         else
         {
            this._filterList.appendText(text);
         }
         this.onTextChange();
      }
      
      public function getCurrentOptions() : Object {
         var data:Object = new Object();
         data.excludeMode = this.excludeMode;
         data.excludeText = this._excludeText;
         data.includeText = this._includeText;
         data.isOn = this.isOn;
         return data;
      }
      
      public function setOptions(data:Object) : void {
         this.excludeMode = data.excludeMode;
         this._excludeText = data.excludeText;
         this._includeText = data.includeText;
         this.isOn = data.isOn;
         this.updateTitleText();
         this.onTextChange();
      }
      
      public function resize() : void {
         var w:* = 0;
         var h:* = 0;
         if((this._filterList) && (this._title))
         {
            this._filterList.width = this._filterList.textWidth + 10;
            if(this._filterList.width < this._title.width)
            {
               this._filterList.width = this._title.width;
            }
            this._filterList.height = this._filterList.textHeight + 10;
            if(this._title.width > this._filterList.width)
            {
               w = this._title.width;
            }
            else
            {
               w = this._filterList.width;
            }
            w = w + 10;
            h = this._filterList.y + this._filterList.height;
            graphics.clear();
            graphics.beginFill(this._backgroundColor);
            graphics.drawRoundRect(0,0,w,h,10);
            graphics.endFill();
            this._filterList.x = 5;
            this._filterList.y = 5 + TITLE_HEIGHT;
            this._title.x = 5;
            this._title.y = 5;
            this._title.height = TITLE_HEIGHT;
         }
      }
      
      private function createUI() : void {
         this._title = new TextField();
         this._title.addEventListener(TextEvent.LINK,this.onTitleClick);
         this._title.multiline = false;
         this._title.selectable = false;
         this._title.autoSize = TextFieldAutoSize.LEFT;
         this._filterList = new TextField();
         this._filterList.addEventListener(TextEvent.LINK,this.onTextClick);
         this._filterList.multiline = true;
         this._filterList.wordWrap = false;
         this._filterList.mouseWheelEnabled = false;
         this._filterList.type = TextFieldType.INPUT;
         this._filterList.addEventListener(Event.CHANGE,this.onTextChange);
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Courier New";
         textFormat.size = 14;
         textFormat.color = 9937645;
         this._filterList.defaultTextFormat = textFormat;
         this._title.defaultTextFormat = textFormat;
         this._title.styleSheet = Console.CONSOLE_STYLE;
         addChild(this._title);
         addChild(this._filterList);
         this.updateTitleText();
         this.resize();
      }
      
      private function updateTitleText() : void {
         if(this.excludeMode)
         {
            this._title.htmlText = "<a href=\'event:change\'><span class=\'red\'>Filter : Exclude mode</span></a>           <a href=\'event:active\'><span class=\'blue\'>(" + (this.isOn?"on":"off") + ")</span></a>";
            this._filterList.text = this._excludeText;
         }
         else
         {
            this._title.htmlText = "<a href=\'event:change\'><span class=\'green\'>Filter : Include mode</span></a>           <a href=\'event:active\'><span class=\'blue\'>(" + (this.isOn?"on":"off") + ")</span></a>";
            this._filterList.text = this._includeText;
         }
      }
      
      private function onTitleClick(event:TextEvent) : void {
         if(event.text == "change")
         {
            this.excludeMode = !this.excludeMode;
            this.updateTitleText();
         }
         else
         {
            if(event.text == "active")
            {
               this.isOn = !this.isOn;
               this.updateTitleText();
            }
         }
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onTextClick(event:TextEvent) : void {
      }
      
      private function onTextChange(event:Event=null) : void {
         if(this.excludeMode)
         {
            this._excludeText = this._filterList.text;
            this._excludeList = this._excludeText.toLocaleLowerCase().split("\r");
         }
         else
         {
            this._includeText = this._filterList.text;
            if(this._includeText)
            {
               this._includeList = this._includeText.toLocaleLowerCase().split("\r");
            }
            else
            {
               this._includeList = new Array();
            }
         }
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private var offsetX:int;
      
      private var offsetY:int;
      
      private function onMouseDown(e:Event) : void {
      }
      
      private function onMouseUp(e:Event) : void {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(e:MouseEvent) : void {
         x = stage.mouseX - this.offsetX;
         y = stage.mouseY - this.offsetY;
         e.updateAfterEvent();
      }
   }
}
