package com.ankamagames.jerakine.logger
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public final class ModuleLogger 
    {

        public static var active:Boolean = false;
        private static var _callbacks:Vector.<Function> = new Vector.<Function>(0);


        public static function log(... args):void
        {
            var f:Function;
            if (active)
            {
                for each (f in _callbacks)
                {
                    f.apply(f, args);
                };
            };
        }

        public static function addCallback(callBack:Function):void
        {
            _callbacks.push(callBack);
        }


    }
}//package com.ankamagames.jerakine.logger

