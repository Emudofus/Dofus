package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeCraftResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeCraftResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5790;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var craftResult:uint = 0;
      
      override public function getMessageId() : uint {
         return 5790;
      }
      
      public function initExchangeCraftResultMessage(craftResult:uint=0) : ExchangeCraftResultMessage {
         this.craftResult = craftResult;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.craftResult = 0;
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
         this.serializeAs_ExchangeCraftResultMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultMessage(output:IDataOutput) : void {
         output.writeByte(this.craftResult);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeCraftResultMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultMessage(input:IDataInput) : void {
         this.craftResult = input.readByte();
         if(this.craftResult < 0)
         {
            throw new Error("Forbidden value (" + this.craftResult + ") on element of ExchangeCraftResultMessage.craftResult.");
         }
         else
         {
            return;
         }
      }
   }
}
