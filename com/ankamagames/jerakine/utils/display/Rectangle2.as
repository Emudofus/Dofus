package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.interfaces.*;
    import flash.geom.*;

    public class Rectangle2 extends Object implements IRectangle
    {
        private var _x:Number;
        private var _y:Number;
        private var _height:Number;
        private var _width:Number;

        public function Rectangle2(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this._x = param1;
            this._y = param2;
            this._width = param3;
            this._height = param4;
            return;
        }// end function

        public function get x() : Number
        {
            return this._x;
        }// end function

        public function set x(param1:Number) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : Number
        {
            return this._y;
        }// end function

        public function set y(param1:Number) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get width() : Number
        {
            return this._width;
        }// end function

        public function set width(param1:Number) : void
        {
            this._width = param1;
            return;
        }// end function

        public function get height() : Number
        {
            return this._height;
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

        public function toString() : String
        {
            return "x " + this._x + ":, y: " + this._y + ", w: " + this._width + ", h: " + this._height;
        }// end function

    }
}
