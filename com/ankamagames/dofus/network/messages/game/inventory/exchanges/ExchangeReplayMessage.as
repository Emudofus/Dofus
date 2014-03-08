package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeReplayMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeReplayMessage() {
         super();
      }
      
      public static const protocolId:uint = 6002;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var count:int = 0;
      
      override public function getMessageId() : uint {
         return 6002;
      }
      
      public function initExchangeReplayMessage(param1:int=0) : ExchangeReplayMessage {
         this.count = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.count = 0;
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
         this.serializeAs_ExchangeReplayMessage(param1);
      }
      
      public function serializeAs_ExchangeReplayMessage(param1:IDataOutput) : void {
         param1.writeInt(this.count);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeReplayMessage(param1);
      }
      
      public function deserializeAs_ExchangeReplayMessage(param1:IDataInput) : void {
         this.count = param1.readInt();
      }
   }
}
