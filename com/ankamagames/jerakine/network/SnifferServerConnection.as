package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.network.*;
    import flash.events.*;

    public class SnifferServerConnection extends ServerConnection implements IServerConnection
    {
        private var _targetHost:String;
        private var _targetPort:int;
        private static var _snifferHost:String;
        private static var _snifferPort:int;

        public function SnifferServerConnection(param1:String = null, param2:int = 0)
        {
            super(null, 0);
            if (param1 != null && param2 != 0)
            {
                this.connect(param1, param2);
            }
            return;
        }// end function

        override public function connect(param1:String, param2:int) : void
        {
            if (_snifferHost == null || _snifferPort == 0)
            {
                throw new NetworkError("Can\'t connect using an analyzer-proxy without host and port for this proxy.");
            }
            this._targetHost = param1;
            this._targetPort = param2;
            super.connect(_snifferHost, _snifferPort);
            return;
        }// end function

        override protected function onConnect(event:Event) : void
        {
            writeUTF(this._targetHost);
            writeUnsignedInt(this._targetPort);
            super.onConnect(event);
            return;
        }// end function

        public static function get snifferHost() : String
        {
            return _snifferHost;
        }// end function

        public static function set snifferHost(param1:String) : void
        {
            _snifferHost = param1;
            return;
        }// end function

        public static function get snifferPort() : int
        {
            return _snifferPort;
        }// end function

        public static function set snifferPort(param1:int) : void
        {
            _snifferPort = param1;
            return;
        }// end function

    }
}
