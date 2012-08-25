package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import com.ankamagames.jerakine.types.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;

    public class FileTarget extends AbstractTarget implements ConfigurableLoggingTarget
    {
        private var _name:String;
        private static var _socket:XMLSocket = new XMLSocket();
        private static var _history:Array = new Array();
        private static var _connecting:Boolean = false;
        private static var _fileStream:FileStream = new FileStream();

        public function FileTarget()
        {
            var _loc_1:* = new Date();
            this._name = CustomSharedObject.getCustomSharedObjectDirectory() + "/logs/log_" + _loc_1.fullYear + "-" + _loc_1.month + "-" + _loc_1.day + "_" + _loc_1.hours + "h" + _loc_1.minutes + "m" + _loc_1.seconds + "s" + _loc_1.milliseconds + ".log";
            var _loc_2:* = new File(this._name);
            _fileStream.openAsync(_loc_2, FileMode.WRITE);
            return;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            if (event is TextLogEvent)
            {
                send(event.level, event.message + "\n");
            }
            return;
        }// end function

        public function configure(param1:XML) : void
        {
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        private static function send(param1:int, param2:String) : void
        {
            _fileStream.writeUTFBytes("[" + param1 + "] " + param2);
            return;
        }// end function

        private static function getKeyName(param1:int) : String
        {
            switch(param1)
            {
                case LogLevel.TRACE:
                {
                    return "trace";
                }
                case LogLevel.DEBUG:
                {
                    return "debug";
                }
                case LogLevel.INFO:
                {
                    return "info";
                }
                case LogLevel.WARN:
                {
                    return "warning";
                }
                case LogLevel.ERROR:
                {
                    return "error";
                }
                case LogLevel.FATAL:
                {
                    return "fatal";
                }
                default:
                {
                    break;
                }
            }
            return "severe";
        }// end function

        private static function onSocket(event:Event) : void
        {
            var _loc_2:LoggerHistoryElement = null;
            _connecting = false;
            for each (_loc_2 in _history)
            {
                
                send(_loc_2.level, _loc_2.message);
            }
            _history = new Array();
            return;
        }// end function

        private static function onSocketError(event:Event) : void
        {
            _connecting = false;
            return;
        }// end function

    }
}
