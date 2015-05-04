package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.messages.IdentifiedMessage;
   import com.ankamagames.jerakine.messages.QueueableMessage;
   
   public interface INetworkMessage extends IdentifiedMessage, QueueableMessage
   {
      
      function pack(param1:ICustomDataOutput) : void;
      
      function unpack(param1:ICustomDataInput, param2:uint) : void;
      
      function get isInitialized() : Boolean;
   }
}
