package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initExchangeTypesItemsExchangerDescriptionForUserMessage(itemTypeDescriptions:Vector.<BidExchangerObjectInfo> = null) : ExchangeTypesItemsExchangerDescriptionForUserMessage {
         this.itemTypeDescriptions = itemTypeDescriptions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.itemTypeDescriptions = new Vector.<BidExchangerObjectInfo>();
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
         this.serializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(output);
      }
      
      public function serializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(output:IDataOutput) : void {
         output.writeShort(this.itemTypeDescriptions.length);
         var _i1:uint = 0;
         while(_i1 < this.itemTypeDescriptions.length)
         {
            (this.itemTypeDescriptions[_i1] as BidExchangerObjectInfo).serializeAs_BidExchangerObjectInfo(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(input);
      }
      
      public function deserializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(input:IDataInput) : void {
         var _item1:BidExchangerObjectInfo = null;
         var _itemTypeDescriptionsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _itemTypeDescriptionsLen)
         {
            _item1 = new BidExchangerObjectInfo();
            _item1.deserialize(input);
            this.itemTypeDescriptions.push(_item1);
            _i1++;
         }
      }
   }
}
