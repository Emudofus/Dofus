package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeIsReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeIsReadyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5509;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      public var ready:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5509;
      }
      
      public function initExchangeIsReadyMessage(id:uint=0, ready:Boolean=false) : ExchangeIsReadyMessage {
         this.id = id;
         this.ready = ready;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.ready = false;
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
         this.serializeAs_ExchangeIsReadyMessage(output);
      }
      
      public function serializeAs_ExchangeIsReadyMessage(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            output.writeBoolean(this.ready);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeIsReadyMessage(input);
      }
      
      public function deserializeAs_ExchangeIsReadyMessage(input:IDataInput) : void {
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ExchangeIsReadyMessage.id.");
         }
         else
         {
            this.ready = input.readBoolean();
            return;
         }
      }
   }
}
