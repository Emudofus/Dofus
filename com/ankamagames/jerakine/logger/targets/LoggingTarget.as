package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.LogEvent;

    public interface LoggingTarget 
    {

        function set filters(_arg_1:Array):void;
        function get filters():Array;
        function addLogger(_arg_1:Logger):void;
        function removeLogger(_arg_1:Logger):void;
        function onLog(_arg_1:LogEvent):void;

    }
}//package com.ankamagames.jerakine.logger.targets

