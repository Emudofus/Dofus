package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeRequestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeRequestedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5522;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var exchangeType:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5522;
      }
      
      public function initExchangeRequestedMessage(param1:int = 0) : ExchangeRequestedMessage
      {
         this.exchangeType = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.exchangeType = 0;
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
         this.serializeAs_ExchangeRequestedMessage(param1);
      }
      
      public function serializeAs_ExchangeRequestedMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.exchangeType);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeRequestedMessage(param1);
      }
      
      public function deserializeAs_ExchangeRequestedMessage(param1:ICustomDataInput) : void
      {
         this.exchangeType = param1.readByte();
      }
   }
}
