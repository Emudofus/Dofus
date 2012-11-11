package com.ankamagames.dofus.console.moduleLogger
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    final public class TextFieldOldScrollBarH extends Sprite
    {
        private var _textField:TextField;
        private var _power:int = 4;
        private var _backgroundColor:uint;
        private var _color:uint;
        private var _background:Shape;
        private var _scrollBar:Sprite;
        private var offsetX:int;
        public static const HEIGHT:int = 10;

        public function TextFieldOldScrollBarH(param1:TextField, param2:int, param3:uint, param4:uint)
        {
            this._textField = param1;
            this._power = param2;
            this._backgroundColor = param3;
            this._color = param4;
            this._textField.mouseEnabled = true;
            this.createUI();
            return;
        }// end function

        public function resize() : void
        {
            this._background.graphics.clear();
            this._background.graphics.beginFill(this._backgroundColor);
            this._background.graphics.drawRoundRect(0, 0, this._textField.width, HEIGHT, 5);
            this._background.graphics.endFill();
            x = this._textField.x;
            y = this._textField.y + this._textField.height;
            this.drawScrollBar();
            return;
        }// end function

        private function updateTextPosition() : void
        {
            var _loc_1:* = this._scrollBar.x / (this._textField.width - this._scrollBar.width);
            this._textField.scrollH = this._textField.maxScrollH * _loc_1;
            return;
        }// end function

        private function drawScrollBar() : void
        {
            if (this._textField.maxScrollH <= 1)
            {
                visible = false;
                return;
            }
            visible = true;
            var _loc_1:* = this._textField.width / this._textField.textWidth;
            var _loc_2:* = int(this._textField.width * _loc_1);
            if (_loc_2 < 40)
            {
                _loc_2 = 40;
            }
            this._scrollBar.graphics.clear();
            this._scrollBar.graphics.beginFill(this._color);
            this._scrollBar.graphics.drawRoundRect(0, 0, _loc_2, HEIGHT, 5);
            this._scrollBar.graphics.endFill();
            this._scrollBar.x = this._textField.scrollH * (this._textField.width - this._scrollBar.width) / this._textField.maxScrollH;
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
            this.offsetX = this._scrollBar.mouseX;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
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
            var _loc_2:* = stage.mouseX - this.offsetX;
            var _loc_3:* = this._textField.width - this._scrollBar.width;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            else if (_loc_2 > _loc_3)
            {
                _loc_2 = _loc_3;
            }
            this._scrollBar.x = _loc_2;
            this.updateTextPosition();
            event.updateAfterEvent();
            return;
        }// end function

    }
}
