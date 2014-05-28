package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHousePriceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHousePriceMessage() {
         super();
      }
      
      public static const protocolId:uint = 5805;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var genId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5805;
      }
      
      public function initExchangeBidHousePriceMessage(genId:uint = 0) : ExchangeBidHousePriceMessage {
         this.genId = genId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.genId = 0;
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
         this.serializeAs_ExchangeBidHousePriceMessage(output);
      }
      
      public function serializeAs_ExchangeBidHousePriceMessage(output:IDataOutput) : void {
         if(this.genId < 0)
         {
            throw new Error("Forbidden value (" + this.genId + ") on element genId.");
         }
         else
         {
            output.writeInt(this.genId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHousePriceMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHousePriceMessage(input:IDataInput) : void {
         this.genId = input.readInt();
         if(this.genId < 0)
         {
            throw new Error("Forbidden value (" + this.genId + ") on element of ExchangeBidHousePriceMessage.genId.");
         }
         else
         {
            return;
         }
      }
   }
}
