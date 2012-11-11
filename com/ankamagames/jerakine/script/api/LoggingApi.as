package com.ankamagames.jerakine.script.api
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class LoggingApi extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LoggingApi));

        public function LoggingApi()
        {
            return;
        }// end function

        public static function Trace(param1, param2:uint = 0) : void
        {
            var _loc_3:* = "" + (param1 != null ? (param1) : ("NULL"));
            _log.log(param2, _loc_3);
            return;
        }// end function

    }
}
