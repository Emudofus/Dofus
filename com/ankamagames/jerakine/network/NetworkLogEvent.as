package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;

    public class NetworkLogEvent extends LogEvent
    {
        private var _msg:INetworkMessage;
        private var _isServerMsg:Boolean;

        public function NetworkLogEvent(param1:INetworkMessage, param2:Boolean)
        {
            super(null, null, 0);
            this._msg = param1;
            this._isServerMsg = param2;
            return;
        }// end function

        public function get networkMessage() : INetworkMessage
        {
            return this._msg;
        }// end function

        public function get isServerMsg() : Boolean
        {
            return this._isServerMsg;
        }// end function

        override public function clone() : Event
        {
            return new NetworkLogEvent(this._msg, this._isServerMsg);
        }// end function

    }
}
