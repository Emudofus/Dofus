package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkTaxCollectorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkTaxCollectorMessage() {
         this.objectsInfos = new Vector.<ObjectItem>();
         super();
      }
      
      public static const protocolId:uint = 5780;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var collectorId:int = 0;
      
      public var objectsInfos:Vector.<ObjectItem>;
      
      public var goldInfo:uint = 0;
      
      override public function getMessageId() : uint {
         return 5780;
      }
      
      public function initExchangeStartOkTaxCollectorMessage(param1:int=0, param2:Vector.<ObjectItem>=null, param3:uint=0) : ExchangeStartOkTaxCollectorMessage {
         this.collectorId = param1;
         this.objectsInfos = param2;
         this.goldInfo = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.collectorId = 0;
         this.objectsInfos = new Vector.<ObjectItem>();
         this.goldInfo = 0;
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
         this.serializeAs_ExchangeStartOkTaxCollectorMessage(param1);
      }
      
      public function serializeAs_ExchangeStartOkTaxCollectorMessage(param1:IDataOutput) : void {
         param1.writeInt(this.collectorId);
         param1.writeShort(this.objectsInfos.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.objectsInfos.length)
         {
            (this.objectsInfos[_loc2_] as ObjectItem).serializeAs_ObjectItem(param1);
            _loc2_++;
         }
         if(this.goldInfo < 0)
         {
            throw new Error("Forbidden value (" + this.goldInfo + ") on element goldInfo.");
         }
         else
         {
            param1.writeInt(this.goldInfo);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkTaxCollectorMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartOkTaxCollectorMessage(param1:IDataInput) : void {
         var _loc4_:ObjectItem = null;
         this.collectorId = param1.readInt();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ObjectItem();
            _loc4_.deserialize(param1);
            this.objectsInfos.push(_loc4_);
            _loc3_++;
         }
         this.goldInfo = param1.readInt();
         if(this.goldInfo < 0)
         {
            throw new Error("Forbidden value (" + this.goldInfo + ") on element of ExchangeStartOkTaxCollectorMessage.goldInfo.");
         }
         else
         {
            return;
         }
      }
   }
}
