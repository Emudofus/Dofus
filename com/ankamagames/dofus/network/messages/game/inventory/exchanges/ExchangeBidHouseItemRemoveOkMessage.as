package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseItemRemoveOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseItemRemoveOkMessage() {
         super();
      }
      
      public static const protocolId:uint = 5946;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var sellerId:int = 0;
      
      override public function getMessageId() : uint {
         return 5946;
      }
      
      public function initExchangeBidHouseItemRemoveOkMessage(sellerId:int=0) : ExchangeBidHouseItemRemoveOkMessage {
         this.sellerId = sellerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sellerId = 0;
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
         this.serializeAs_ExchangeBidHouseItemRemoveOkMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseItemRemoveOkMessage(output:IDataOutput) : void {
         output.writeInt(this.sellerId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseItemRemoveOkMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseItemRemoveOkMessage(input:IDataInput) : void {
         this.sellerId = input.readInt();
      }
   }
}
