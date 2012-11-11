package com.ankamagames.jerakine.network.messages
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;

    public class ServerConnectionClosedMessage extends Object implements Message
    {
        private var _closedConnection:ServerConnection;

        public function ServerConnectionClosedMessage(param1:ServerConnection)
        {
            this._closedConnection = param1;
            return;
        }// end function

        public function get closedConnection() : ServerConnection
        {
            return this._closedConnection;
        }// end function

    }
}
