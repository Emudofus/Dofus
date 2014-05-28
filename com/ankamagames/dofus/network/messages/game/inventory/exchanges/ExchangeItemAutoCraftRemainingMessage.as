package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeItemAutoCraftRemainingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeItemAutoCraftRemainingMessage() {
         super();
      }
      
      public static const protocolId:uint = 6015;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var count:uint = 0;
      
      override public function getMessageId() : uint {
         return 6015;
      }
      
      public function initExchangeItemAutoCraftRemainingMessage(count:uint = 0) : ExchangeItemAutoCraftRemainingMessage {
         this.count = count;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.count = 0;
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
         this.serializeAs_ExchangeItemAutoCraftRemainingMessage(output);
      }
      
      public function serializeAs_ExchangeItemAutoCraftRemainingMessage(output:IDataOutput) : void {
         if(this.count < 0)
         {
            throw new Error("Forbidden value (" + this.count + ") on element count.");
         }
         else
         {
            output.writeInt(this.count);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeItemAutoCraftRemainingMessage(input);
      }
      
      public function deserializeAs_ExchangeItemAutoCraftRemainingMessage(input:IDataInput) : void {
         this.count = input.readInt();
         if(this.count < 0)
         {
            throw new Error("Forbidden value (" + this.count + ") on element of ExchangeItemAutoCraftRemainingMessage.count.");
         }
         else
         {
            return;
         }
      }
   }
}
