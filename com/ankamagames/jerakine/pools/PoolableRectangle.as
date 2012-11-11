package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.pools.*;
    import flash.geom.*;

    public class PoolableRectangle extends Rectangle implements Poolable
    {

        public function PoolableRectangle(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        public function renew(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : PoolableRectangle
        {
            this.x = param1;
            this.y = param2;
            this.width = param3;
            this.height = param4;
            return this;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function extend(param1:Rectangle) : void
        {
            var _loc_2:* = this.union(param1);
            x = _loc_2.x;
            y = _loc_2.y;
            width = _loc_2.width;
            height = _loc_2.height;
            return;
        }// end function

    }
}
