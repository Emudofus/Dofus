package com.ankamagames.berilia.types.tooltip
{
    import com.ankamagames.jerakine.interfaces.*;
    import flash.geom.*;

    public class TooltipRectangle extends Object implements IRectangle
    {
        private var _x:Number;
        private var _y:Number;
        private var _width:Number;
        private var _height:Number;

        public function TooltipRectangle(param1:Number, param2:Number, param3:Number, param4:Number)
        {
            this.x = param1;
            this.y = param2;
            this.width = param3;
            this.height = param4;
            return;
        }// end function

        public function get x() : Number
        {
            return this._x;
        }// end function

        public function get y() : Number
        {
            return this._y;
        }// end function

        public function get width() : Number
        {
            return this._width;
        }// end function

        public function get height() : Number
        {
            return this._height;
        }// end function

        public function set x(param1:Number) : void
        {
            this._x = param1;
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            this._y = param1;
            return;
        }// end function

        public function set width(param1:Number) : void
        {
            this._width = param1;
            return;
        }// end function

        public function set height(param1:Number) : void
        {
            this._height = param1;
            return;
        }// end function

        public function localToGlobal(param1:Point) : Point
        {
            return param1;
        }// end function

        public function globalToLocal(param1:Point) : Point
        {
            return param1;
        }// end function

    }
}
