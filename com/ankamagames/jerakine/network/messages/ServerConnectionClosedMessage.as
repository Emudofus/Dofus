package com.ankamagames.jerakine.network.messages
{
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.network.ServerConnection;

    public class ServerConnectionClosedMessage implements Message 
    {

        private var _closedConnection:ServerConnection;

        public function ServerConnectionClosedMessage(closedConnection:ServerConnection)
        {
            this._closedConnection = closedConnection;
        }

        public function get closedConnection():ServerConnection
        {
            return (this._closedConnection);
        }


    }
}//package com.ankamagames.jerakine.network.messages

