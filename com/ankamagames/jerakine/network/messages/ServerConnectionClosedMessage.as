package com.ankamagames.jerakine.network.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.ServerConnection;
   
   public class ServerConnectionClosedMessage extends Object implements Message
   {
      
      public function ServerConnectionClosedMessage(param1:ServerConnection) {
         super();
         this._closedConnection = param1;
      }
      
      private var _closedConnection:ServerConnection;
      
      public function get closedConnection() : ServerConnection {
         return this._closedConnection;
      }
   }
}
