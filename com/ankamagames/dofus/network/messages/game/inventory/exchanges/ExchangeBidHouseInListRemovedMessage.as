package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseInListRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseInListRemovedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5950;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var itemUID:int = 0;
      
      override public function getMessageId() : uint {
         return 5950;
      }
      
      public function initExchangeBidHouseInListRemovedMessage(itemUID:int=0) : ExchangeBidHouseInListRemovedMessage {
         this.itemUID = itemUID;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.itemUID = 0;
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
         this.serializeAs_ExchangeBidHouseInListRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseInListRemovedMessage(output:IDataOutput) : void {
         output.writeInt(this.itemUID);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseInListRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseInListRemovedMessage(input:IDataInput) : void {
         this.itemUID = input.readInt();
      }
   }
}
