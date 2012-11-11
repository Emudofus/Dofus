package com.ankamagames.jerakine.network.messages
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;

    public class ServerConnectionFailedMessage extends Object implements Message
    {
        private var _failedConnection:ServerConnection;
        private var _errorMessage:String;

        public function ServerConnectionFailedMessage(param1:ServerConnection, param2:String)
        {
            this._errorMessage = param2;
            this._failedConnection = param1;
            return;
        }// end function

        public function get failedConnection() : ServerConnection
        {
            return this._failedConnection;
        }// end function

        public function get errorMessage() : String
        {
            return this._errorMessage;
        }// end function

    }
}
