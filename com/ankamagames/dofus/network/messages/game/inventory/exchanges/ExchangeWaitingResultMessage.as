package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeWaitingResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeWaitingResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5786;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var bwait:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5786;
      }
      
      public function initExchangeWaitingResultMessage(param1:Boolean=false) : ExchangeWaitingResultMessage {
         this.bwait = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.bwait = false;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeWaitingResultMessage(param1);
      }
      
      public function serializeAs_ExchangeWaitingResultMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.bwait);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeWaitingResultMessage(param1);
      }
      
      public function deserializeAs_ExchangeWaitingResultMessage(param1:IDataInput) : void {
         this.bwait = param1.readBoolean();
      }
   }
}
