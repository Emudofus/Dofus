package com.ankamagames.dofus.console.moduleLogger
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public final class TextFieldScrollBar extends Sprite
   {
      
      public function TextFieldScrollBar(textField:TextField, lines:Vector.<String>, power:int, backgroundColor:uint, color:uint) {
         super();
         this._textField = textField;
         this._lines = lines;
         this._power = power;
         this._backgroundColor = backgroundColor;
         this._color = color;
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
      
      public function reset(lines:Vector.<String>) : void {
         this._textField.text = "";
         this._lines = lines;
      }
      
      public function resize(numLines:int = 0) : void {
         if(numLines)
         {
            this._numLines = numLines;
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
      
      public function scrollText(value:int) : void {
         if(value == -1)
         {
            value = this._scroll;
         }
         this._scrollAtEnd = false;
         if(value < 0)
         {
            value = 0;
         }
         else if(value >= this._lines.length - this._numLines)
         {
            this._scrollAtEnd = true;
            value = this._lines.length - this._numLines;
         }
         
         this._textField.htmlText = this._lines.slice(value,value + this._numLines).join("\n");
         this._scroll = value;
         this._maxScroll = this._lines.length - this._numLines;
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function scrollAtEnd() : void {
         var num:int = this._lines.length;
         var value:int = num - this._numLines;
         if(value < 0)
         {
            value = 0;
         }
         this._textField.htmlText = this._lines.slice(value).join("\n");
         this._scroll = this._lines.length;
         this._maxScroll = this._scroll;
         this._scrollAtEnd = true;
         this.resize();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function updateTextPosition() : void {
         var p:Number = this._scrollBar.y / (this._textField.height - this._scrollBar.height);
         this.scrollText(this._maxScroll * p);
      }
      
      private function drawScrollBar() : void {
         if(this._lines.length <= this._numLines)
         {
            visible = false;
            this._scrollAtEnd = true;
            return;
         }
         visible = true;
         var pHeight:Number = this._numLines / this._lines.length;
         var vHeight:int = int(this._textField.height * pHeight);
         if(vHeight < 40)
         {
            vHeight = 40;
         }
         this._scrollBar.graphics.clear();
         this._scrollBar.graphics.beginFill(this._color);
         this._scrollBar.graphics.drawRoundRect(0,0,WIDTH,vHeight,5);
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
      
      private function onScrollBarMouseDown(mouseEvent:MouseEvent) : void {
         this.offsetY = this._scrollBar.mouseY;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseWheel(mouseEvent:MouseEvent) : void {
         if(!visible)
         {
            return;
         }
         var scroll:int = this._scroll + (mouseEvent.delta < 0?1:-1) * this._power;
         if(scroll < 0)
         {
            scroll = 0;
         }
         this.scrollText(scroll);
         this.resize();
      }
      
      private function onMouseUp(mouseEvent:MouseEvent) : void {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function onMouseMove(mouseEvent:MouseEvent) : void {
         var value:int = mouseY - this.offsetY;
         var maxValue:int = this._textField.height - this._scrollBar.height;
         if(value < 0)
         {
            value = 0;
         }
         else if(value > maxValue)
         {
            value = maxValue;
         }
         
         this._scrollBar.y = value;
         this.updateTextPosition();
         mouseEvent.updateAfterEvent();
      }
   }
}
