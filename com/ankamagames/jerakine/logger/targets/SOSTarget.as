package com.ankamagames.jerakine.logger.targets
{
    import flash.net.XMLSocket;
    import com.ankamagames.jerakine.logger.LogLevel;
    import flash.events.Event;
    import com.ankamagames.jerakine.logger.TextLogEvent;
    import com.ankamagames.jerakine.logger.LogEvent;

    public class SOSTarget extends AbstractTarget implements ConfigurableLoggingTarget 
    {

        private static var _socket:XMLSocket = new XMLSocket();
        private static var _history:Array = new Array();
        private static var _connecting:Boolean = false;
        public static var enabled:Boolean = true;
        public static var serverHost:String = "localhost";
        public static var serverPort:int = 4444;


        private static function send(level:int, message:String):void
        {
            var _local_3:LoggerHistoryElement;
            if (_socket.connected)
            {
                if (level != LogLevel.COMMANDS)
                {
                    _socket.send((((('!SOS<showMessage key="' + getKeyName(level)) + '"><![CDATA[') + message) + "]]></showMessage>"));
                }
                else
                {
                    _socket.send((("!SOS<" + message) + "/>"));
                };
            }
            else
            {
                if (!(_socket.hasEventListener("connect")))
                {
                    _socket.addEventListener("connect", onSocket);
                    _socket.addEventListener("ioError", onSocketError);
                    _socket.addEventListener("securityError", onSocketError);
                };
                if (!(_connecting))
                {
                    _socket.connect(serverHost, serverPort);
                    _connecting = true;
                };
                _local_3 = new LoggerHistoryElement(level, message);
                _history.push(_local_3);
            };
        }

        private static function getKeyName(level:int):String
        {
            switch (level)
            {
                case LogLevel.TRACE:
                    return ("trace");
                case LogLevel.DEBUG:
                    return ("debug");
                case LogLevel.INFO:
                    return ("info");
                case LogLevel.WARN:
                    return ("warning");
                case LogLevel.ERROR:
                    return ("error");
                case LogLevel.FATAL:
                    return ("fatal");
            };
            return ("severe");
        }

        private static function onSocket(e:Event):void
        {
            var o:LoggerHistoryElement;
            _connecting = false;
            for each (o in _history)
            {
                send(o.level, o.message);
            };
            _history = new Array();
        }

        private static function onSocketError(e:Event):void
        {
            _connecting = false;
        }


        public function get socket():XMLSocket
        {
            return (_socket);
        }

        public function get connected():Boolean
        {
            return (_connecting);
        }

        override public function logEvent(event:LogEvent):void
        {
            var msg:String;
            if (((enabled) && ((event is TextLogEvent))))
            {
                msg = event.message;
                if (event.level == LogLevel.COMMANDS)
                {
                    switch (msg)
                    {
                        case "clear":
                            msg = "<clear/>";
                            break;
                    };
                };
                send(event.level, event.message);
            };
        }

        public function configure(config:XML):void
        {
            if (config..server.@host != undefined)
            {
                serverHost = String(config..server.@host);
            };
            if (config..server.@port != undefined)
            {
                serverPort = int(config..server.@port);
            };
        }


    }
}//package com.ankamagames.jerakine.logger.targets

