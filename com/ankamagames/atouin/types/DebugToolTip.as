package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;

    public class DebugToolTip extends Sprite
    {
        private var _shape:Shape;
        private var _textfield:TextField;
        private static var _self:DebugToolTip;

        public function DebugToolTip()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            mouseEnabled = false;
            mouseChildren = false;
            this._shape = new Shape();
            var _loc_1:* = new DropShadowFilter(0, 45, 4473924, 0.5, 4, 4, 1, 1);
            filters = [_loc_1];
            addChild(this._shape);
            this._textfield = new TextField();
            this._textfield.autoSize = TextFieldAutoSize.LEFT;
            addChild(this._textfield);
            return;
        }// end function

        public function set text(param1:String) : void
        {
            this._textfield.text = param1;
            this._shape.x = this._textfield.x - 4;
            this._shape.y = this._textfield.y - 4;
            this._shape.graphics.clear();
            this._shape.graphics.beginFill(16777215, 0.7);
            this._shape.graphics.drawRect(0, 0, this._textfield.textWidth + 8, this._textfield.textHeight + 8);
            return;
        }// end function

        public static function getInstance() : DebugToolTip
        {
            if (!_self)
            {
                _self = new DebugToolTip;
            }
            return _self;
        }// end function

    }
}
