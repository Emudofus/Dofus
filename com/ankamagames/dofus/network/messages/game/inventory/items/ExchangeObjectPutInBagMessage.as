package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectPutInBagMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public function ExchangeObjectPutInBagMessage() {
         this.object = new ObjectItem();
         super();
      }
      
      public static const protocolId:uint = 6009;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var object:ObjectItem;
      
      override public function getMessageId() : uint {
         return 6009;
      }
      
      public function initExchangeObjectPutInBagMessage(param1:Boolean=false, param2:ObjectItem=null) : ExchangeObjectPutInBagMessage {
         super.initExchangeObjectMessage(param1);
         this.object = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.object = new ObjectItem();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeObjectPutInBagMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectPutInBagMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMessage(param1);
         this.object.serializeAs_ObjectItem(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeObjectPutInBagMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectPutInBagMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.object = new ObjectItem();
         this.object.deserialize(param1);
      }
   }
}
