package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectMoveKamaMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeObjectMoveKamaMessage() {
         super();
      }
      
      public static const protocolId:uint = 5520;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var quantity:int = 0;
      
      override public function getMessageId() : uint {
         return 5520;
      }
      
      public function initExchangeObjectMoveKamaMessage(quantity:int=0) : ExchangeObjectMoveKamaMessage {
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.quantity = 0;
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
         this.serializeAs_ExchangeObjectMoveKamaMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMoveKamaMessage(output:IDataOutput) : void {
         output.writeInt(this.quantity);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeObjectMoveKamaMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMoveKamaMessage(input:IDataInput) : void {
         this.quantity = input.readInt();
      }
   }
}
