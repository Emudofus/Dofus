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
      
      public function initExchangeBidHouseGenericItemAddedMessage(param1:int=0) : ExchangeBidHouseGenericItemAddedMessage {
         this.objGenericId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objGenericId = 0;
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
         this.serializeAs_ExchangeBidHouseGenericItemAddedMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseGenericItemAddedMessage(param1:IDataOutput) : void {
         param1.writeInt(this.objGenericId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseGenericItemAddedMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseGenericItemAddedMessage(param1:IDataInput) : void {
         this.objGenericId = param1.readInt();
      }
   }
}
