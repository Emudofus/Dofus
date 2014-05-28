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
      
      public function initExchangeCraftResultWithObjectDescMessage(craftResult:uint = 0, objectInfo:ObjectItemNotInContainer = null) : ExchangeCraftResultWithObjectDescMessage {
         super.initExchangeCraftResultMessage(craftResult);
         this.objectInfo = objectInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectInfo = new ObjectItemNotInContainer();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeCraftResultWithObjectDescMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultWithObjectDescMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeCraftResultMessage(output);
         this.objectInfo.serializeAs_ObjectItemNotInContainer(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeCraftResultWithObjectDescMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultWithObjectDescMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.objectInfo = new ObjectItemNotInContainer();
         this.objectInfo.deserialize(input);
      }
   }
}
