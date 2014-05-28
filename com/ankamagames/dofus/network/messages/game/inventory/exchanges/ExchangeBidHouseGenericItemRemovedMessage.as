package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseGenericItemRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseGenericItemRemovedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5948;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objGenericId:int = 0;
      
      override public function getMessageId() : uint {
         return 5948;
      }
      
      public function initExchangeBidHouseGenericItemRemovedMessage(objGenericId:int = 0) : ExchangeBidHouseGenericItemRemovedMessage {
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
         this.serializeAs_ExchangeBidHouseGenericItemRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseGenericItemRemovedMessage(output:IDataOutput) : void {
         output.writeInt(this.objGenericId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseGenericItemRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseGenericItemRemovedMessage(input:IDataInput) : void {
         this.objGenericId = input.readInt();
      }
   }
}
