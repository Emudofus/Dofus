package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeItemGoldAddAsPaymentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeItemGoldAddAsPaymentMessage() {
         super();
      }
      
      public static const protocolId:uint = 5770;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paymentType:int = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 5770;
      }
      
      public function initExchangeItemGoldAddAsPaymentMessage(param1:int=0, param2:uint=0) : ExchangeItemGoldAddAsPaymentMessage {
         this.paymentType = param1;
         this.quantity = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paymentType = 0;
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
         this.serializeAs_ExchangeItemGoldAddAsPaymentMessage(param1);
      }
      
      public function serializeAs_ExchangeItemGoldAddAsPaymentMessage(param1:IDataOutput) : void {
         param1.writeByte(this.paymentType);
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
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeItemGoldAddAsPaymentMessage(param1);
      }
      
      public function deserializeAs_ExchangeItemGoldAddAsPaymentMessage(param1:IDataInput) : void {
         this.paymentType = param1.readByte();
         this.quantity = param1.readInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeItemGoldAddAsPaymentMessage.quantity.");
         }
         else
         {
            return;
         }
      }
   }
}
