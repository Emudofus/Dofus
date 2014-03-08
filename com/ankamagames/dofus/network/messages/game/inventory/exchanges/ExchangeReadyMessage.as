package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReadyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5511;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ready:Boolean = false;
      
      public var step:uint = 0;
      
      override public function getMessageId() : uint {
         return 5511;
      }
      
      public function initExchangeReadyMessage(ready:Boolean=false, step:uint=0) : ExchangeReadyMessage {
         this.ready = ready;
         this.step = step;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ready = false;
         this.step = 0;
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
         this.serializeAs_ExchangeReadyMessage(output);
      }
      
      public function serializeAs_ExchangeReadyMessage(output:IDataOutput) : void {
         output.writeBoolean(this.ready);
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element step.");
         }
         else
         {
            output.writeShort(this.step);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeReadyMessage(input);
      }
      
      public function deserializeAs_ExchangeReadyMessage(input:IDataInput) : void {
         this.ready = input.readBoolean();
         this.step = input.readShort();
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element of ExchangeReadyMessage.step.");
         }
         else
         {
            return;
         }
      }
   }
}
