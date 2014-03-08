package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeRequestOnTaxCollectorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeRequestOnTaxCollectorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5779;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var taxCollectorId:int = 0;
      
      override public function getMessageId() : uint {
         return 5779;
      }
      
      public function initExchangeRequestOnTaxCollectorMessage(taxCollectorId:int=0) : ExchangeRequestOnTaxCollectorMessage {
         this.taxCollectorId = taxCollectorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.taxCollectorId = 0;
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
         this.serializeAs_ExchangeRequestOnTaxCollectorMessage(output);
      }
      
      public function serializeAs_ExchangeRequestOnTaxCollectorMessage(output:IDataOutput) : void {
         output.writeInt(this.taxCollectorId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeRequestOnTaxCollectorMessage(input);
      }
      
      public function deserializeAs_ExchangeRequestOnTaxCollectorMessage(input:IDataInput) : void {
         this.taxCollectorId = input.readInt();
      }
   }
}
