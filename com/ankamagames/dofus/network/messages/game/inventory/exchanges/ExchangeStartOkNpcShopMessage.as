package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkNpcShopMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkNpcShopMessage() {
         this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>();
         super();
      }
      
      public static const protocolId:uint = 5761;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var npcSellerId:int = 0;
      
      public var tokenId:uint = 0;
      
      public var objectsInfos:Vector.<ObjectItemToSellInNpcShop>;
      
      override public function getMessageId() : uint {
         return 5761;
      }
      
      public function initExchangeStartOkNpcShopMessage(npcSellerId:int=0, tokenId:uint=0, objectsInfos:Vector.<ObjectItemToSellInNpcShop>=null) : ExchangeStartOkNpcShopMessage {
         this.npcSellerId = npcSellerId;
         this.tokenId = tokenId;
         this.objectsInfos = objectsInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.npcSellerId = 0;
         this.tokenId = 0;
         this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>();
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
         this.serializeAs_ExchangeStartOkNpcShopMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkNpcShopMessage(output:IDataOutput) : void {
         output.writeInt(this.npcSellerId);
         if(this.tokenId < 0)
         {
            throw new Error("Forbidden value (" + this.tokenId + ") on element tokenId.");
         }
         else
         {
            output.writeInt(this.tokenId);
            output.writeShort(this.objectsInfos.length);
            _i3 = 0;
            while(_i3 < this.objectsInfos.length)
            {
               (this.objectsInfos[_i3] as ObjectItemToSellInNpcShop).serializeAs_ObjectItemToSellInNpcShop(output);
               _i3++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkNpcShopMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkNpcShopMessage(input:IDataInput) : void {
         var _item3:ObjectItemToSellInNpcShop = null;
         this.npcSellerId = input.readInt();
         this.tokenId = input.readInt();
         if(this.tokenId < 0)
         {
            throw new Error("Forbidden value (" + this.tokenId + ") on element of ExchangeStartOkNpcShopMessage.tokenId.");
         }
         else
         {
            _objectsInfosLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _objectsInfosLen)
            {
               _item3 = new ObjectItemToSellInNpcShop();
               _item3.deserialize(input);
               this.objectsInfos.push(_item3);
               _i3++;
            }
            return;
         }
      }
   }
}
