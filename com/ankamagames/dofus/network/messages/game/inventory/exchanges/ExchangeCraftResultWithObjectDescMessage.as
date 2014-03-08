package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeCraftResultWithObjectDescMessage extends ExchangeCraftResultMessage implements INetworkMessage
   {
      
      public function ExchangeCraftResultWithObjectDescMessage() {
         this.objectInfo = new ObjectItemNotInContainer();
         super();
      }
      
      public static const protocolId:uint = 5999;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var objectInfo:ObjectItemNotInContainer;
      
      override public function getMessageId() : uint {
         return 5999;
      }
      
      public function initExchangeCraftResultWithObjectDescMessage(param1:uint=0, param2:ObjectItemNotInContainer=null) : ExchangeCraftResultWithObjectDescMessage {
         super.initExchangeCraftResultMessage(param1);
         this.objectInfo = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectInfo = new ObjectItemNotInContainer();
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
         this.serializeAs_ExchangeCraftResultWithObjectDescMessage(param1);
      }
      
      public function serializeAs_ExchangeCraftResultWithObjectDescMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeCraftResultMessage(param1);
         this.objectInfo.serializeAs_ObjectItemNotInContainer(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeCraftResultWithObjectDescMessage(param1);
      }
      
      public function deserializeAs_ExchangeCraftResultWithObjectDescMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.objectInfo = new ObjectItemNotInContainer();
         this.objectInfo.deserialize(param1);
      }
   }
}
