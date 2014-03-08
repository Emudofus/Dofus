package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeObjectModifyPricedMessage extends ExchangeObjectMovePricedMessage implements INetworkMessage
   {
      
      public function ExchangeObjectModifyPricedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6238;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6238;
      }
      
      public function initExchangeObjectModifyPricedMessage(param1:uint=0, param2:int=0, param3:int=0) : ExchangeObjectModifyPricedMessage {
         super.initExchangeObjectMovePricedMessage(param1,param2,param3);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_ExchangeObjectModifyPricedMessage(param1);
      }
      
      public function serializeAs_ExchangeObjectModifyPricedMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeObjectMovePricedMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeObjectModifyPricedMessage(param1);
      }
      
      public function deserializeAs_ExchangeObjectModifyPricedMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
