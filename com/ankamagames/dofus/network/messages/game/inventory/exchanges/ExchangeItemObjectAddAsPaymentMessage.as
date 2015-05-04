package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeItemObjectAddAsPaymentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeItemObjectAddAsPaymentMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5766;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var paymentType:uint = 0;
      
      public var bAdd:Boolean = false;
      
      public var objectToMoveId:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5766;
      }
      
      public function initExchangeItemObjectAddAsPaymentMessage(param1:uint = 0, param2:Boolean = false, param3:uint = 0, param4:uint = 0) : ExchangeItemObjectAddAsPaymentMessage
      {
         this.paymentType = param1;
         this.bAdd = param2;
         this.objectToMoveId = param3;
         this.quantity = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.paymentType = 0;
         this.bAdd = false;
         this.objectToMoveId = 0;
         this.quantity = 0;
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
         this.serializeAs_ExchangeItemObjectAddAsPaymentMessage(param1);
      }
      
      public function serializeAs_ExchangeItemObjectAddAsPaymentMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.paymentType);
         param1.writeBoolean(this.bAdd);
         if(this.objectToMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToMoveId + ") on element objectToMoveId.");
         }
         else
         {
            param1.writeVarInt(this.objectToMoveId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               param1.writeVarInt(this.quantity);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeItemObjectAddAsPaymentMessage(param1);
      }
      
      public function deserializeAs_ExchangeItemObjectAddAsPaymentMessage(param1:ICustomDataInput) : void
      {
         this.paymentType = param1.readByte();
         if(this.paymentType < 0)
         {
            throw new Error("Forbidden value (" + this.paymentType + ") on element of ExchangeItemObjectAddAsPaymentMessage.paymentType.");
         }
         else
         {
            this.bAdd = param1.readBoolean();
            this.objectToMoveId = param1.readVarUhInt();
            if(this.objectToMoveId < 0)
            {
               throw new Error("Forbidden value (" + this.objectToMoveId + ") on element of ExchangeItemObjectAddAsPaymentMessage.objectToMoveId.");
            }
            else
            {
               this.quantity = param1.readVarUhInt();
               if(this.quantity < 0)
               {
                  throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeItemObjectAddAsPaymentMessage.quantity.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
