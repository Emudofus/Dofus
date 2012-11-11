package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.types.uiDefinition.*;
    import flash.geom.*;

    public class GraphicSize extends Point
    {
        private var _nXUnit:uint;
        private var _nYUnit:uint;
        public static const SIZE_PIXEL:uint = 0;
        public static const SIZE_PRC:uint = 1;

        public function GraphicSize()
        {
            x = NaN;
            y = NaN;
            return;
        }// end function

        public function setX(param1:Number, param2:uint) : void
        {
            x = param1;
            this._nXUnit = param2;
            return;
        }// end function

        public function setY(param1:Number, param2:uint) : void
        {
            y = param1;
            this._nYUnit = param2;
            return;
        }// end function

        public function get xUnit() : uint
        {
            return this._nXUnit;
        }// end function

        public function get yUnit() : uint
        {
            return this._nYUnit;
        }// end function

        public function toSizeElement() : SizeElement
        {
            var _loc_1:* = new SizeElement();
            if (!isNaN(x))
            {
                _loc_1.x = x;
                _loc_1.xUnit = this._nXUnit;
            }
            if (!isNaN(y))
            {
                _loc_1.y = y;
                _loc_1.yUnit = this._nYUnit;
            }
            return _loc_1;
        }// end function

    }
}
