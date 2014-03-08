package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectMessage() {
         super();
      }
      
      public static const protocolId:uint = 5515;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var remote:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5515;
      }
      
      public function initExchangeObjectMessage(remote:Boolean=false) : ExchangeObjectMessage {
         this.remote = remote;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.remote = false;
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
         this.serializeAs_ExchangeObjectMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMessage(output:IDataOutput) : void {
         output.writeBoolean(this.remote);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMessage(input:IDataInput) : void {
         this.remote = input.readBoolean();
      }
   }
}
