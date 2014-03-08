package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeGoldPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeGoldPaymentForCraftMessage() {
         super();
      }
      
      public static const protocolId:uint = 5833;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var onlySuccess:Boolean = false;
      
      public var goldSum:uint = 0;
      
      override public function getMessageId() : uint {
         return 5833;
      }
      
      public function initExchangeGoldPaymentForCraftMessage(onlySuccess:Boolean=false, goldSum:uint=0) : ExchangeGoldPaymentForCraftMessage {
         this.onlySuccess = onlySuccess;
         this.goldSum = goldSum;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.onlySuccess = false;
         this.goldSum = 0;
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
         this.serializeAs_ExchangeGoldPaymentForCraftMessage(output);
      }
      
      public function serializeAs_ExchangeGoldPaymentForCraftMessage(output:IDataOutput) : void {
         output.writeBoolean(this.onlySuccess);
         if(this.goldSum < 0)
         {
            throw new Error("Forbidden value (" + this.goldSum + ") on element goldSum.");
         }
         else
         {
            output.writeInt(this.goldSum);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeGoldPaymentForCraftMessage(input);
      }
      
      public function deserializeAs_ExchangeGoldPaymentForCraftMessage(input:IDataInput) : void {
         this.onlySuccess = input.readBoolean();
         this.goldSum = input.readInt();
         if(this.goldSum < 0)
         {
            throw new Error("Forbidden value (" + this.goldSum + ") on element of ExchangeGoldPaymentForCraftMessage.goldSum.");
         }
         else
         {
            return;
         }
      }
   }
}
