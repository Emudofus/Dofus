package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.pools.*;
    import flash.geom.*;

    public class PoolablePoint extends Point implements Poolable
    {

        public function PoolablePoint(param1:Number = 0, param2:Number = 0)
        {
            super(param1, param2);
            return;
        }// end function

        public function renew(param1:Number = 0, param2:Number = 0) : Point
        {
            this.x = param1;
            this.y = param2;
            return this;
        }// end function

        public function free() : void
        {
            return;
        }// end function

    }
}
