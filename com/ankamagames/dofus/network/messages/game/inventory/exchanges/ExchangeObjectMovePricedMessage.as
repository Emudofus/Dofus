package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectMovePricedMessage extends ExchangeObjectMoveMessage implements INetworkMessage
   {
      
      public function ExchangeObjectMovePricedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5514;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var price:int = 0;
      
      override public function getMessageId() : uint {
         return 5514;
      }
      
      public function initExchangeObjectMovePricedMessage(param1:uint=0, param2:int=0, param3:int=0) : ExchangeObjectMovePricedMessage {
         super.initExchangeObjectMoveMessage(param1,param2);
         this.price = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.price = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeObjectMovePricedMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectMovePricedMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMoveMessage(param1);
         param1.writeInt(this.price);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeObjectMovePricedMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectMovePricedMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.price = param1.readInt();
      }
   }
}
