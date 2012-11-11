package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.*;

    public interface LoggingTarget
    {

        public function LoggingTarget();

        function set filters(param1:Array) : void;

        function get filters() : Array;

        function addLogger(param1:Logger) : void;

        function removeLogger(param1:Logger) : void;

        function onLog(event:LogEvent) : void;

    }
}
