package com.ankamagames.jerakine.network
{
   import flash.events.Event;
   
   public class NetworkSentEvent extends Event
   {
      
      public function NetworkSentEvent(param1:String, param2:INetworkMessage) {
         super(param1,false,false);
         this._message = param2;
      }
      
      public static const EVENT_SENT:String = "messageSent";
      
      private var _message:INetworkMessage;
      
      public function get message() : INetworkMessage {
         return this._message;
      }
   }
}
