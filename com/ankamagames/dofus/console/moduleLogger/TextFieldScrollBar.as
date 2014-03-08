package com.ankamagames.dofus.console.moduleLogger
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import __AS3__.vec.Vector;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public final class TextFieldScrollBar extends Sprite
   {
      
      public function TextFieldScrollBar(param1:TextField, param2:Vector.<String>, param3:int, param4:uint, param5:uint) {
         super();
         this._textField = param1;
         this._lines = param2;
         this._power = param3;
         this._backgroundColor = param4;
         this._color = param5;
         this._textField.mouseEnabled = true;
         this._textField.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this.createUI();
      }
      
      public static const WIDTH:int = 10;
      
      private var _textField:TextField;
      
      private var _lines:Vector.<String>;
      
      private var _numLines:int = 20;
      
      private var _power:int = 4;
      
      private var _scroll:int;
      
      private var _maxScroll:int;
      
      private var _scrollAtEnd:Boolean;
      
      private var _backgroundColor:uint;
      
      private var _color:uint;
      
      private var _background:Shape;
      
      private var _scrollBar:Sprite;
      
      public function reset(param1:Vector.<String>) : void {
         this._textField.text = "";
         this._lines = param1;
      }
      
      public function resize(param1:int=0) : void {
         if(param1)
         {
            this._numLines = param1;
         }
         this._background.graphics.clear();
         this._background.graphics.beginFill(this._backgroundColor);
         this._background.graphics.drawRoundRect(0,0,WIDTH,this._textField.height,5);
         this._background.graphics.endFill();
         x = this._textField.x + this._textField.width;
         y = this._textField.y;
         this.drawScrollBar();
      }
      
      public function updateScrolling() : void {
         if(this._scrollAtEnd)
         {
            this.scrollAtEnd();
         }
         else
         {
            this._maxScroll = this._lines.length - this._numLines;
            this.drawScrollBar();
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function scrollText(param1:int) : void {
         if(param1 == -1)
         {
            param1 = this._scroll;
         }
         this._scrollAtEnd = false;
         if(param1 < 0)
         {
            param1 = 0;
         }
         else
         {
            if(param1 >= this._lines.length - this._numLines)
            {
               this._scrollAtEnd = true;
               param1 = this._lines.length - this._numLines;
            }
         }
         this._textField.htmlText = this._lines.slice(param1,param1 + this._numLines).join("\n");
         this._scroll = param1;
         this._maxScroll = this._lines.length - this._numLines;
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function scrollAtEnd() : void {
         var _loc1_:int = this._lines.length;
         var _loc2_:int = _loc1_ - this._numLines;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this._textField.htmlText = this._lines.slice(_loc2_).join("\n");
         this._scroll = this._lines.length;
         this._maxScroll = this._scroll;
         this._scrollAtEnd = true;
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function updateTextPosition() : void {
         var _loc1_:Number = this._scrollBar.y / (this._textField.height - this._scrollBar.height);
         this.scrollText(this._maxScroll * _loc1_);
      }
      
      private function drawScrollBar() : void {
         if(this._lines.length <= this._numLines)
         {
            visible = false;
            this._scrollAtEnd = true;
            return;
         }
         visible = true;
         var _loc1_:Number = this._numLines / this._lines.length;
         var _loc2_:int = int(this._textField.height * _loc1_);
         if(_loc2_ < 40)
         {
            _loc2_ = 40;
         }
         this._scrollBar.graphics.clear();
         this._scrollBar.graphics.beginFill(this._color);
         this._scrollBar.graphics.drawRoundRect(0,0,WIDTH,_loc2_,5);
         this._scrollBar.graphics.endFill();
         this._scrollBar.y = this._scroll * (this._textField.height - this._scrollBar.height) / this._maxScroll;
      }
      
      private function createUI() : void {
         if(this._background)
         {
            throw new Error();
         }
         else
         {
            this._background = new Shape();
            this._scrollBar = new Sprite();
            this._scrollBar.mouseChildren = false;
            this._scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollBarMouseDown);
            addChild(this._background);
            addChild(this._scrollBar);
            this.resize();
            return;
         }
      }
      
      private var offsetY:int;
      
      private function onScrollBarMouseDown(param1:MouseEvent) : void {
         this.offsetY = this._scrollBar.mouseY;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void {
         if(!visible)
         {
            return;
         }
         var _loc2_:int = this._scroll + (param1.delta < 0?1:-1) * this._power;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.scrollText(_loc2_);
         this.resize();
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseMove(param1:MouseEvent) : void {
         var _loc2_:int = mouseY - this.offsetY;
         var _loc3_:int = this._textField.height - this._scrollBar.height;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else
         {
            if(_loc2_ > _loc3_)
            {
               _loc2_ = _loc3_;
            }
         }
         this._scrollBar.y = _loc2_;
         this.updateTextPosition();
         param1.updateAfterEvent();
      }
   }
}
