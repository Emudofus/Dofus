package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.BidExchangerObjectInfo;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeTypesItemsExchangerDescriptionForUserMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeTypesItemsExchangerDescriptionForUserMessage() {
         this.itemTypeDescriptions = new Vector.<BidExchangerObjectInfo>();
         super();
      }
      
      public static const protocolId:uint = 5752;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var itemTypeDescriptions:Vector.<BidExchangerObjectInfo>;
      
      override public function getMessageId() : uint {
         return 5752;
      }
      
      public function initExchangeTypesItemsExchangerDescriptionForUserMessage(param1:Vector.<BidExchangerObjectInfo>=null) : ExchangeTypesItemsExchangerDescriptionForUserMessage {
         this.itemTypeDescriptions = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.itemTypeDescriptions = new Vector.<BidExchangerObjectInfo>();
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
         this.serializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(param1);
      }
      
      public function serializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(param1:IDataOutput) : void {
         param1.writeShort(this.itemTypeDescriptions.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.itemTypeDescriptions.length)
         {
            (this.itemTypeDescriptions[_loc2_] as BidExchangerObjectInfo).serializeAs_BidExchangerObjectInfo(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(param1);
      }
      
      public function deserializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(param1:IDataInput) : void {
         var _loc4_:BidExchangerObjectInfo = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new BidExchangerObjectInfo();
            _loc4_.deserialize(param1);
            this.itemTypeDescriptions.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
