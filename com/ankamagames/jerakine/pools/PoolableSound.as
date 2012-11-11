package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.pools.*;
    import flash.media.*;

    public class PoolableSound extends Sound implements Poolable
    {

        public function PoolableSound()
        {
            return;
        }// end function

        public function renew() : Sound
        {
            return this;
        }// end function

        public function free() : void
        {
            return;
        }// end function

    }
}
