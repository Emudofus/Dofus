package com.ankamagames.jerakine.pools
{
    import flash.net.URLLoader;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.net.URLRequest;
    import flash.errors.IOError;

    public class PoolableURLLoader extends URLLoader implements Poolable 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableURLLoader));

        public function PoolableURLLoader(request:URLRequest=null)
        {
            super(request);
        }

        public function free():void
        {
            try
            {
                close();
            }
            catch(ioe:IOError)
            {
            };
        }


    }
}//package com.ankamagames.jerakine.pools

