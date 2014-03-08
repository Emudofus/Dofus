package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeItemObjectAddAsPaymentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeItemObjectAddAsPaymentMessage() {
         super();
      }
      
      public static const protocolId:uint = 5766;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paymentType:int = 0;
      
      public var bAdd:Boolean = false;
      
      public var objectToMoveId:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 5766;
      }
      
      public function initExchangeItemObjectAddAsPaymentMessage(paymentType:int=0, bAdd:Boolean=false, objectToMoveId:uint=0, quantity:uint=0) : ExchangeItemObjectAddAsPaymentMessage {
         this.paymentType = paymentType;
         this.bAdd = bAdd;
         this.objectToMoveId = objectToMoveId;
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paymentType = 0;
         this.bAdd = false;
         this.objectToMoveId = 0;
         this.quantity = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeItemObjectAddAsPaymentMessage(output);
      }
      
      public function serializeAs_ExchangeItemObjectAddAsPaymentMessage(output:IDataOutput) : void {
         output.writeByte(this.paymentType);
         output.writeBoolean(this.bAdd);
         if(this.objectToMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToMoveId + ") on element objectToMoveId.");
         }
         else
         {
            output.writeInt(this.objectToMoveId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               output.writeInt(this.quantity);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeItemObjectAddAsPaymentMessage(input);
      }
      
      public function deserializeAs_ExchangeItemObjectAddAsPaymentMessage(input:IDataInput) : void {
         this.paymentType = input.readByte();
         this.bAdd = input.readBoolean();
         this.objectToMoveId = input.readInt();
         if(this.objectToMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToMoveId + ") on element of ExchangeItemObjectAddAsPaymentMessage.objectToMoveId.");
         }
         else
         {
            this.quantity = input.readInt();
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
