package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseGenericItemAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseGenericItemAddedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5947;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objGenericId:int = 0;
      
      override public function getMessageId() : uint {
         return 5947;
      }
      
      public function initExchangeBidHouseGenericItemAddedMessage(objGenericId:int=0) : ExchangeBidHouseGenericItemAddedMessage {
         this.objGenericId = objGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objGenericId = 0;
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
         this.serializeAs_ExchangeBidHouseGenericItemAddedMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseGenericItemAddedMessage(output:IDataOutput) : void {
         output.writeInt(this.objGenericId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseGenericItemAddedMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseGenericItemAddedMessage(input:IDataInput) : void {
         this.objGenericId = input.readInt();
      }
   }
}
