package com.ankamagames.dofus.console.moduleLogger
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    final public class TextFieldScrollBar extends Sprite
    {
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
        private var offsetY:int;
        public static const WIDTH:int = 10;

        public function TextFieldScrollBar(param1:TextField, param2:Vector.<String>, param3:int, param4:uint, param5:uint)
        {
            this._textField = param1;
            this._lines = param2;
            this._power = param3;
            this._backgroundColor = param4;
            this._color = param5;
            this._textField.mouseEnabled = true;
            this._textField.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            this.createUI();
            return;
        }// end function

        public function resize(param1:int = 0) : void
        {
            if (param1)
            {
                this._numLines = param1;
            }
            this._background.graphics.clear();
            this._background.graphics.beginFill(this._backgroundColor);
            this._background.graphics.drawRoundRect(0, 0, WIDTH, this._textField.height, 5);
            this._background.graphics.endFill();
            x = this._textField.x + this._textField.width;
            y = this._textField.y;
            this.drawScrollBar();
            return;
        }// end function

        public function updateScrolling() : void
        {
            if (this._scrollAtEnd)
            {
                this.scrollAtEnd();
            }
            else
            {
                this._maxScroll = this._lines.length - this._numLines;
                this.drawScrollBar();
                dispatchEvent(new Event(Event.CHANGE));
            }
            return;
        }// end function

        public function scrollText(param1:int) : void
        {
            if (param1 == -1)
            {
                param1 = this._scroll;
            }
            this._scrollAtEnd = false;
            if (param1 < 0)
            {
                param1 = 0;
            }
            else if (param1 >= this._lines.length - this._numLines)
            {
                this._scrollAtEnd = true;
                param1 = this._lines.length - this._numLines;
            }
            this._textField.htmlText = this._lines.slice(param1, param1 + this._numLines).join("\n");
            this._scroll = param1;
            this._maxScroll = this._lines.length - this._numLines;
            this.resize();
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function scrollAtEnd() : void
        {
            var _loc_1:* = this._lines.length;
            var _loc_2:* = _loc_1 - this._numLines;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            this._textField.htmlText = this._lines.slice(_loc_2).join("\n");
            this._scroll = this._lines.length;
            this._maxScroll = this._scroll;
            this._scrollAtEnd = true;
            this.resize();
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        private function updateTextPosition() : void
        {
            var _loc_1:* = this._scrollBar.y / (this._textField.height - this._scrollBar.height);
            this.scrollText(this._maxScroll * _loc_1);
            return;
        }// end function

        private function drawScrollBar() : void
        {
            if (this._lines.length <= this._numLines)
            {
                visible = false;
                this._scrollAtEnd = true;
                return;
            }
            visible = true;
            var _loc_1:* = this._numLines / this._lines.length;
            var _loc_2:* = int(this._textField.height * _loc_1);
            if (_loc_2 < 40)
            {
                _loc_2 = 40;
            }
            this._scrollBar.graphics.clear();
            this._scrollBar.graphics.beginFill(this._color);
            this._scrollBar.graphics.drawRoundRect(0, 0, WIDTH, _loc_2, 5);
            this._scrollBar.graphics.endFill();
            this._scrollBar.y = this._scroll * (this._textField.height - this._scrollBar.height) / this._maxScroll;
            return;
        }// end function

        private function createUI() : void
        {
            if (this._background)
            {
                throw new Error();
            }
            this._background = new Shape();
            this._scrollBar = new Sprite();
            this._scrollBar.mouseChildren = false;
            this._scrollBar.addEventListener(MouseEvent.MOUSE_DOWN, this.onScrollBarMouseDown);
            addChild(this._background);
            addChild(this._scrollBar);
            this.resize();
            return;
        }// end function

        private function onScrollBarMouseDown(event:MouseEvent) : void
        {
            this.offsetY = this._scrollBar.mouseY;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            return;
        }// end function

        private function onMouseWheel(event:MouseEvent) : void
        {
            if (!visible)
            {
                return;
            }
            var _loc_2:* = this._scroll + (event.delta < 0 ? (1) : (-1)) * this._power;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            this.scrollText(_loc_2);
            this.resize();
            return;
        }// end function

        private function onMouseUp(event:MouseEvent) : void
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            return;
        }// end function

        private function onMouseMove(event:MouseEvent) : void
        {
            var _loc_2:* = mouseY - this.offsetY;
            var _loc_3:* = this._textField.height - this._scrollBar.height;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            else if (_loc_2 > _loc_3)
            {
                _loc_2 = _loc_3;
            }
            this._scrollBar.y = _loc_2;
            this.updateTextPosition();
            event.updateAfterEvent();
            return;
        }// end function

    }
}
