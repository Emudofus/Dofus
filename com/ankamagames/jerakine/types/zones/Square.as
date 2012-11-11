package com.ankamagames.jerakine.types.zones
{
    import com.ankamagames.jerakine.map.*;

    public class Square extends ZRectangle
    {

        public function Square(param1:uint, param2:uint, param3:IDataMapProvider)
        {
            super(param1, param2, param2, param3);
            return;
        }// end function

        override public function get surface() : uint
        {
            return Math.pow(radius * 2 + 1, 2);
        }// end function

    }
}
