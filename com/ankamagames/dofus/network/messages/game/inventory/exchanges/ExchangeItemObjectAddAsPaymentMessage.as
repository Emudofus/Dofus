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
      
      public function initExchangeItemObjectAddAsPaymentMessage(param1:int=0, param2:Boolean=false, param3:uint=0, param4:uint=0) : ExchangeItemObjectAddAsPaymentMessage {
         this.paymentType = param1;
         this.bAdd = param2;
         this.objectToMoveId = param3;
         this.quantity = param4;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeItemObjectAddAsPaymentMessage(param1);
      }
      
      public function serializeAs_ExchangeItemObjectAddAsPaymentMessage(param1:IDataOutput) : void {
         param1.writeByte(this.paymentType);
         param1.writeBoolean(this.bAdd);
         if(this.objectToMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToMoveId + ") on element objectToMoveId.");
         }
         else
         {
            param1.writeInt(this.objectToMoveId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               param1.writeInt(this.quantity);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeItemObjectAddAsPaymentMessage(param1);
      }
      
      public function deserializeAs_ExchangeItemObjectAddAsPaymentMessage(param1:IDataInput) : void {
         this.paymentType = param1.readByte();
         this.bAdd = param1.readBoolean();
         this.objectToMoveId = param1.readInt();
         if(this.objectToMoveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToMoveId + ") on element of ExchangeItemObjectAddAsPaymentMessage.objectToMoveId.");
         }
         else
         {
            this.quantity = param1.readInt();
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
