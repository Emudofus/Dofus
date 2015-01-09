package com.ankamagames.jerakine.pools
{
    import flash.display.Loader;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;

    public class PoolableLoader extends Loader implements Poolable 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableLoader));


        public function free():void
        {
            unload();
        }


    }
}//package com.ankamagames.jerakine.pools

