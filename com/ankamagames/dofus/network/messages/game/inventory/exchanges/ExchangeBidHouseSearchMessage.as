package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeBidHouseSearchMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseSearchMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5806;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      public var genId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5806;
      }
      
      public function initExchangeBidHouseSearchMessage(param1:uint = 0, param2:uint = 0) : ExchangeBidHouseSearchMessage
      {
         this.type = param1;
         this.genId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
         this.genId = 0;
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
         this.serializeAs_ExchangeBidHouseSearchMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseSearchMessage(param1:ICustomDataOutput) : void
      {
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element type.");
         }
         else
         {
            param1.writeVarInt(this.type);
            if(this.genId < 0)
            {
               throw new Error("Forbidden value (" + this.genId + ") on element genId.");
            }
            else
            {
               param1.writeVarShort(this.genId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseSearchMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseSearchMessage(param1:ICustomDataInput) : void
      {
         this.type = param1.readVarUhInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseSearchMessage.type.");
         }
         else
         {
            this.genId = param1.readVarUhShort();
            if(this.genId < 0)
            {
               throw new Error("Forbidden value (" + this.genId + ") on element of ExchangeBidHouseSearchMessage.genId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
