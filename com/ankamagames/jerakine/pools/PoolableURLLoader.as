package com.ankamagames.jerakine.pools
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.pools.*;
    import flash.errors.*;
    import flash.net.*;
    import flash.utils.*;

    public class PoolableURLLoader extends URLLoader implements Poolable
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PoolableURLLoader));

        public function PoolableURLLoader(param1:URLRequest = null)
        {
            super(param1);
            return;
        }// end function

        public function free() : void
        {
            try
            {
                close();
            }
            catch (ioe:IOError)
            {
            }
            return;
        }// end function

    }
}
