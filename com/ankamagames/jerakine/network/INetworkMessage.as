package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.messages.IdentifiedMessage;
   import com.ankamagames.jerakine.messages.QueueableMessage;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public interface INetworkMessage extends IdentifiedMessage, QueueableMessage
   {
      
      function pack(param1:IDataOutput) : void;
      
      function unpack(param1:IDataInput, param2:uint) : void;
      
      function get isInitialized() : Boolean;
   }
}
