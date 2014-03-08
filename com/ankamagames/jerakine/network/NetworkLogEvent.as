package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import flash.events.Event;
   
   public class NetworkLogEvent extends LogEvent
   {
      
      public function NetworkLogEvent(param1:INetworkMessage, param2:Boolean) {
         super(null,null,0);
         this._msg = param1;
         this._isServerMsg = param2;
      }
      
      private var _msg:INetworkMessage;
      
      private var _isServerMsg:Boolean;
      
      public function get networkMessage() : INetworkMessage {
         return this._msg;
      }
      
      public function get isServerMsg() : Boolean {
         return this._isServerMsg;
      }
      
      override public function clone() : Event {
         return new NetworkLogEvent(this._msg,this._isServerMsg);
      }
   }
}
