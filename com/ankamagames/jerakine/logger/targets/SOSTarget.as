package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import flash.events.*;
    import flash.net.*;

    public class SOSTarget extends AbstractTarget implements ConfigurableLoggingTarget
    {
        private static var _socket:XMLSocket = new XMLSocket();
        private static var _history:Array = new Array();
        private static var _connecting:Boolean = false;
        public static var enabled:Boolean = true;
        public static var serverHost:String = "localhost";
        public static var serverPort:int = 4444;

        public function SOSTarget()
        {
            return;
        }// end function

        public function get socket() : XMLSocket
        {
            return _socket;
        }// end function

        public function get connected() : Boolean
        {
            return _connecting;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            var _loc_2:* = null;
            if (enabled && event is TextLogEvent)
            {
                _loc_2 = event.message;
                if (event.level == LogLevel.COMMANDS)
                {
                    switch(_loc_2)
                    {
                        case "clear":
                        {
                            _loc_2 = "<clear/>";
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                send(event.level, event.message);
            }
            return;
        }// end function

        public function configure(param1:XML) : void
        {
            if (param1..server.@host != undefined)
            {
                serverHost = String(param1..server.@host);
            }
            if (param1..server.@port != undefined)
            {
                serverPort = int(param1..server.@port);
            }
            return;
        }// end function

        private static function send(param1:int, param2:String) : void
        {
            var _loc_3:* = null;
            if (_socket.connected)
            {
                if (param1 != LogLevel.COMMANDS)
                {
                    _socket.send("!SOS<showMessage key=\"" + getKeyName(param1) + "\"><![CDATA[" + param2 + "]]></showMessage>");
                }
                else
                {
                    _socket.send("!SOS<" + param2 + "/>");
                }
            }
            else
            {
                if (!_socket.hasEventListener("connect"))
                {
                    _socket.addEventListener("connect", onSocket);
                    _socket.addEventListener("ioError", onSocketError);
                    _socket.addEventListener("securityError", onSocketError);
                }
                if (!_connecting)
                {
                    _socket.connect(serverHost, serverPort);
                    _connecting = true;
                }
                _loc_3 = new LoggerHistoryElement(param1, param2);
                _history.push(_loc_3);
            }
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
            var _loc_2:* = null;
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
