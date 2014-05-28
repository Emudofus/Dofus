package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInBid;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseItemAddOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseItemAddOkMessage() {
         this.itemInfo = new ObjectItemToSellInBid();
         super();
      }
      
      public static const protocolId:uint = 5945;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var itemInfo:ObjectItemToSellInBid;
      
      override public function getMessageId() : uint {
         return 5945;
      }
      
      public function initExchangeBidHouseItemAddOkMessage(itemInfo:ObjectItemToSellInBid = null) : ExchangeBidHouseItemAddOkMessage {
         this.itemInfo = itemInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.itemInfo = new ObjectItemToSellInBid();
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
         this.serializeAs_ExchangeBidHouseItemAddOkMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseItemAddOkMessage(output:IDataOutput) : void {
         this.itemInfo.serializeAs_ObjectItemToSellInBid(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseItemAddOkMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseItemAddOkMessage(input:IDataInput) : void {
         this.itemInfo = new ObjectItemToSellInBid();
         this.itemInfo.deserialize(input);
      }
   }
}
