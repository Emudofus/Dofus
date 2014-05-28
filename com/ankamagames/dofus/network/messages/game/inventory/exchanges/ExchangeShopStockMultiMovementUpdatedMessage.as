package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeShopStockMultiMovementUpdatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeShopStockMultiMovementUpdatedMessage() {
         this.objectInfoList = new Vector.<ObjectItemToSell>();
         super();
      }
      
      public static const protocolId:uint = 6038;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectInfoList:Vector.<ObjectItemToSell>;
      
      override public function getMessageId() : uint {
         return 6038;
      }
      
      public function initExchangeShopStockMultiMovementUpdatedMessage(objectInfoList:Vector.<ObjectItemToSell> = null) : ExchangeShopStockMultiMovementUpdatedMessage {
         this.objectInfoList = objectInfoList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectInfoList = new Vector.<ObjectItemToSell>();
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
         this.serializeAs_ExchangeShopStockMultiMovementUpdatedMessage(output);
      }
      
      public function serializeAs_ExchangeShopStockMultiMovementUpdatedMessage(output:IDataOutput) : void {
         output.writeShort(this.objectInfoList.length);
         var _i1:uint = 0;
         while(_i1 < this.objectInfoList.length)
         {
            (this.objectInfoList[_i1] as ObjectItemToSell).serializeAs_ObjectItemToSell(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeShopStockMultiMovementUpdatedMessage(input);
      }
      
      public function deserializeAs_ExchangeShopStockMultiMovementUpdatedMessage(input:IDataInput) : void {
         var _item1:ObjectItemToSell = null;
         var _objectInfoListLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _objectInfoListLen)
         {
            _item1 = new ObjectItemToSell();
            _item1.deserialize(input);
            this.objectInfoList.push(_item1);
            _i1++;
         }
      }
   }
}
