package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkHumanVendorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkHumanVendorMessage() {
         this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
         super();
      }
      
      public static const protocolId:uint = 5767;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var sellerId:uint = 0;
      
      public var objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop>;
      
      override public function getMessageId() : uint {
         return 5767;
      }
      
      public function initExchangeStartOkHumanVendorMessage(sellerId:uint = 0, objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop> = null) : ExchangeStartOkHumanVendorMessage {
         this.sellerId = sellerId;
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.sellerId = 0;
         this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
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
         this.serializeAs_ExchangeStartOkHumanVendorMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkHumanVendorMessage(output:IDataOutput) : void {
         if(this.sellerId < 0)
         {
            throw new Error("Forbidden value (" + this.sellerId + ") on element sellerId.");
         }
         else
         {
            output.writeInt(this.sellerId);
            output.writeShort(this.objectsInfos.length);
            _i2 = 0;
            while(_i2 < this.objectsInfos.length)
            {
               (this.objectsInfos[_i2] as ObjectItemToSellInHumanVendorShop).serializeAs_ObjectItemToSellInHumanVendorShop(output);
               _i2++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkHumanVendorMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkHumanVendorMessage(input:IDataInput) : void {
         var _item2:ObjectItemToSellInHumanVendorShop = null;
         this.sellerId = input.readInt();
         if(this.sellerId < 0)
         {
            throw new Error("Forbidden value (" + this.sellerId + ") on element of ExchangeStartOkHumanVendorMessage.sellerId.");
         }
         else
         {
            _objectsInfosLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _objectsInfosLen)
            {
               _item2 = new ObjectItemToSellInHumanVendorShop();
               _item2.deserialize(input);
               this.objectsInfos.push(_item2);
               _i2++;
            }
            return;
         }
      }
   }
}
