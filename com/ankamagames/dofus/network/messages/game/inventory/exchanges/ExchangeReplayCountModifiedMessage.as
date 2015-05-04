package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeReplayCountModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReplayCountModifiedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6023;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var count:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6023;
      }
      
      public function initExchangeReplayCountModifiedMessage(param1:int = 0) : ExchangeReplayCountModifiedMessage
      {
         this.count = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.count = 0;
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
         this.serializeAs_ExchangeReplayCountModifiedMessage(param1);
      }
      
      public function serializeAs_ExchangeReplayCountModifiedMessage(param1:ICustomDataOutput) : void
      {
         param1.writeVarInt(this.count);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeReplayCountModifiedMessage(param1);
      }
      
      public function deserializeAs_ExchangeReplayCountModifiedMessage(param1:ICustomDataInput) : void
      {
         this.count = param1.readVarInt();
      }
   }
}
