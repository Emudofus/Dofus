package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeCraftResultMagicWithObjectDescMessage extends ExchangeCraftResultWithObjectDescMessage implements INetworkMessage
   {
      
      public function ExchangeCraftResultMagicWithObjectDescMessage() {
         super();
      }
      
      public static const protocolId:uint = 6188;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var magicPoolStatus:int = 0;
      
      override public function getMessageId() : uint {
         return 6188;
      }
      
      public function initExchangeCraftResultMagicWithObjectDescMessage(craftResult:uint = 0, objectInfo:ObjectItemNotInContainer = null, magicPoolStatus:int = 0) : ExchangeCraftResultMagicWithObjectDescMessage {
         super.initExchangeCraftResultWithObjectDescMessage(craftResult,objectInfo);
         this.magicPoolStatus = magicPoolStatus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.magicPoolStatus = 0;
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
         this.serializeAs_ExchangeCraftResultMagicWithObjectDescMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultMagicWithObjectDescMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeCraftResultWithObjectDescMessage(output);
         output.writeByte(this.magicPoolStatus);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeCraftResultMagicWithObjectDescMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultMagicWithObjectDescMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.magicPoolStatus = input.readByte();
      }
   }
}
