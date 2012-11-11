package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.pools.*;
    import flash.display.*;
    import flash.utils.*;

    public class PoolableLoader extends Loader implements Poolable
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableLoader));

        public function PoolableLoader()
        {
            return;
        }// end function

        public function free() : void
        {
            unload();
            return;
        }// end function

    }
}
