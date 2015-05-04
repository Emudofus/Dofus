package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseTypeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseTypeMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5803;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5803;
      }
      
      public function initExchangeBidHouseTypeMessage(param1:uint = 0) : ExchangeBidHouseTypeMessage
      {
         this.type = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
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
         this.serializeAs_ExchangeBidHouseTypeMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseTypeMessage(param1:ICustomDataOutput) : void
      {
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element type.");
         }
         else
         {
            param1.writeVarInt(this.type);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseTypeMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseTypeMessage(param1:ICustomDataInput) : void
      {
         this.type = param1.readVarUhInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseTypeMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
