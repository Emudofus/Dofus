package com.ankamagames.jerakine.logger
{
    public interface Logger 
    {

        function trace(_arg_1:Object):void;
        function debug(_arg_1:Object):void;
        function info(_arg_1:Object):void;
        function warn(_arg_1:Object):void;
        function error(_arg_1:Object):void;
        function fatal(_arg_1:Object):void;
        function log(_arg_1:uint, _arg_2:Object):void;
        function logDirectly(_arg_1:LogEvent):void;
        function get category():String;
        function clear():void;

    }
}//package com.ankamagames.jerakine.logger

