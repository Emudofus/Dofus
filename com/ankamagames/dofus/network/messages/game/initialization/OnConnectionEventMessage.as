package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class OnConnectionEventMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function OnConnectionEventMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5726;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var eventType:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5726;
      }
      
      public function initOnConnectionEventMessage(param1:uint = 0) : OnConnectionEventMessage
      {
         this.eventType = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.eventType = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_OnConnectionEventMessage(param1);
      }
      
      public function serializeAs_OnConnectionEventMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.eventType);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_OnConnectionEventMessage(param1);
      }
      
      public function deserializeAs_OnConnectionEventMessage(param1:ICustomDataInput) : void
      {
         this.eventType = param1.readByte();
         if(this.eventType < 0)
         {
            throw new Error("Forbidden value (" + this.eventType + ") on element of OnConnectionEventMessage.eventType.");
         }
         else
         {
            return;
         }
      }
   }
}
