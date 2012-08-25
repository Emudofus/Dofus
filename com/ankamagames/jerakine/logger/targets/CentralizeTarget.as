package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;
    import flash.net.*;

    public class CentralizeTarget extends AbstractTarget
    {
        private static var _socket:Socket = new Socket();
        private static var _history:Array = new Array();
        private static var _connecting:Boolean = false;
        public static var serverHost:String = "chacha.ankama.lan";
        public static var serverPort:int = 6666;

        public function CentralizeTarget()
        {
            return;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            this.send(event.level, event.message);
            return;
        }// end function

        private function send(param1:uint, param2:String) : void
        {
            var _loc_3:LoggerHistoryElement = null;
            if (_socket.connected)
            {
                _socket.writeUTF("(" + LogLevel.getString(param1) + ") " + param2);
            }
            else
            {
                if (!_socket.hasEventListener("connect"))
                {
                    _socket.addEventListener("connect", this.onSocket);
                    _socket.addEventListener("ioError", this.onSocketError);
                    _socket.addEventListener("securityError", this.onSocketError);
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

        private function onSocket(event:Event) : void
        {
            var _loc_2:LoggerHistoryElement = null;
            _connecting = false;
            for each (_loc_2 in _history)
            {
                
                this.send(_loc_2.level, _loc_2.message);
            }
            _history = new Array();
            return;
        }// end function

        private function onSocketError(event:Event) : void
        {
            _connecting = false;
            return;
        }// end function

    }
}
