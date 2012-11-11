package com.ankamagames.berilia.types.uiDefinition
{
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class SizeElement extends Object
    {
        public var xUnit:uint;
        public var yUnit:uint;
        public var x:Number;
        public var y:Number;
        public static const SIZE_PIXEL:uint = 0;
        public static const SIZE_PRC:uint = 1;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SizeElement));

        public function SizeElement()
        {
            return;
        }// end function

        public function toGraphicSize() : GraphicSize
        {
            var _loc_1:* = new GraphicSize();
            if (!isNaN(this.xUnit))
            {
                _loc_1.setX(this.x, this.xUnit);
            }
            if (!isNaN(this.yUnit))
            {
                _loc_1.setY(this.y, this.yUnit);
            }
            return _loc_1;
        }// end function

    }
}
