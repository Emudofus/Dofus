package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeCraftResultWithObjectIdMessage extends ExchangeCraftResultMessage implements INetworkMessage
   {
      
      public function ExchangeCraftResultWithObjectIdMessage() {
         super();
      }
      
      public static const protocolId:uint = 6000;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var objectGenericId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6000;
      }
      
      public function initExchangeCraftResultWithObjectIdMessage(craftResult:uint = 0, objectGenericId:uint = 0) : ExchangeCraftResultWithObjectIdMessage {
         super.initExchangeCraftResultMessage(craftResult);
         this.objectGenericId = objectGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectGenericId = 0;
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
         this.serializeAs_ExchangeCraftResultWithObjectIdMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultWithObjectIdMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeCraftResultMessage(output);
         if(this.objectGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objectGenericId + ") on element objectGenericId.");
         }
         else
         {
            output.writeInt(this.objectGenericId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeCraftResultWithObjectIdMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultWithObjectIdMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.objectGenericId = input.readInt();
         if(this.objectGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objectGenericId + ") on element of ExchangeCraftResultWithObjectIdMessage.objectGenericId.");
         }
         else
         {
            return;
         }
      }
   }
}
