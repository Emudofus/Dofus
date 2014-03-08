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
      
      public function FilterUI(param1:uint) {
         this._excludeList = new Array();
         this._includeList = new Array();
         super();
         this._backgroundColor = param1;
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
      
      public function isFiltered(param1:String) : Boolean {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var param1:String = param1.toLocaleLowerCase();
         if(this.excludeMode)
         {
            return !(this._excludeList.indexOf(param1) == -1);
         }
         if(this._includeList.length)
         {
            _loc2_ = this._includeList.length;
            _loc3_ = -1;
            while(++_loc3_ < _loc2_)
            {
               if(param1.indexOf(this._includeList[_loc3_]) != -1)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public function addToFilter(param1:String) : void {
         if(this._filterList.text.toLocaleLowerCase().indexOf(param1.toLocaleLowerCase()) != -1)
         {
            return;
         }
         if(this._filterList.text)
         {
            this._filterList.appendText("\n" + param1);
         }
         else
         {
            this._filterList.appendText(param1);
         }
         this.onTextChange();
      }
      
      public function getCurrentOptions() : Object {
         var _loc1_:Object = new Object();
         _loc1_.excludeMode = this.excludeMode;
         _loc1_.excludeText = this._excludeText;
         _loc1_.includeText = this._includeText;
         _loc1_.isOn = this.isOn;
         return _loc1_;
      }
      
      public function setOptions(param1:Object) : void {
         this.excludeMode = param1.excludeMode;
         this._excludeText = param1.excludeText;
         this._includeText = param1.includeText;
         this.isOn = param1.isOn;
         this.updateTitleText();
         this.onTextChange();
      }
      
      public function resize() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
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
               _loc1_ = this._title.width;
            }
            else
            {
               _loc1_ = this._filterList.width;
            }
            _loc1_ = _loc1_ + 10;
            _loc2_ = this._filterList.y + this._filterList.height;
            graphics.clear();
            graphics.beginFill(this._backgroundColor);
            graphics.drawRoundRect(0,0,_loc1_,_loc2_,10);
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
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Courier New";
         _loc1_.size = 14;
         _loc1_.color = 9937645;
         this._filterList.defaultTextFormat = _loc1_;
         this._title.defaultTextFormat = _loc1_;
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
      
      private function onTitleClick(param1:TextEvent) : void {
         if(param1.text == "change")
         {
            this.excludeMode = !this.excludeMode;
            this.updateTitleText();
         }
         else
         {
            if(param1.text == "active")
            {
               this.isOn = !this.isOn;
               this.updateTitleText();
            }
         }
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onTextClick(param1:TextEvent) : void {
      }
      
      private function onTextChange(param1:Event=null) : void {
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
      
      private function onMouseDown(param1:Event) : void {
      }
      
      private function onMouseUp(param1:Event) : void {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(param1:MouseEvent) : void {
         x = stage.mouseX - this.offsetX;
         y = stage.mouseY - this.offsetY;
         param1.updateAfterEvent();
      }
   }
}
