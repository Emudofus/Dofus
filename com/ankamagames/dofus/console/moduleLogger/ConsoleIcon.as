package com.ankamagames.dofus.console.moduleLogger
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    final public class ConsoleIcon extends Sprite
    {
        private var _icon:Sprite;
        private var _cross:Shape;
        private var _size:int;
        private static const I_CANCEL:Class = ConsoleIcon_I_CANCEL;
        private static const I_DISK:Class = ConsoleIcon_I_DISK;
        private static const I_LIST:Class = ConsoleIcon_I_LIST;
        private static const I_BOOK:Class = ConsoleIcon_I_BOOK;
        private static const I_TERMINAL:Class = ConsoleIcon_I_TERMINAL;
        private static const I_SCREEN:Class = ConsoleIcon_I_SCREEN;
        private static const _assets:Dictionary = new Dictionary();

        public function ConsoleIcon(param1:String, param2:int = 16)
        {
            this._size = param2;
            if (_assets[param1])
            {
                this._icon = new _assets[param1];
            }
            else
            {
                this._icon = new MovieClip();
                this._icon.graphics.beginFill(16711935);
                this._icon.graphics.drawRect(0, 0, this._size, this._size);
                this._icon.graphics.endFill();
            }
            this._icon.width = this._size;
            this._icon.height = this._size;
            addChild(this._icon);
            mouseChildren = false;
            useHandCursor = true;
            buttonMode = true;
            addEventListener(MouseEvent.MOUSE_OVER, this.onRollOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onRollOut);
            return;
        }// end function

        public function disable(param1:Boolean) : void
        {
            if (param1)
            {
                if (!this._cross)
                {
                    this._cross = new Shape();
                    this._cross.graphics.lineStyle(2, 14492194);
                    this._cross.graphics.moveTo(0, 0);
                    this._cross.graphics.lineTo(this._size, this._size);
                    this._cross.graphics.moveTo(0, this._size);
                    this._cross.graphics.lineTo(this._size, 0);
                    addChild(this._cross);
                }
            }
            else if (this._cross)
            {
                removeChild(this._cross);
                this._cross = null;
            }
            return;
        }// end function

        public function changeColor(param1:ColorTransform) : void
        {
            this._icon.transform.colorTransform = param1;
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            transform.colorTransform = new ColorTransform(1.4, 1.4, 1.4);
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            transform.colorTransform = new ColorTransform(1, 1, 1);
            return;
        }// end function

        _assets["cancel"] = I_CANCEL;
        _assets["disk"] = I_DISK;
        _assets["list"] = I_LIST;
        _assets["book"] = I_BOOK;
        _assets["terminal"] = I_TERMINAL;
        _assets["screen"] = I_SCREEN;
    }
}
