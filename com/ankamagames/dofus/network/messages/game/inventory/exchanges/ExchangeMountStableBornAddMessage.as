package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMountStableBornAddMessage extends ExchangeMountStableAddMessage implements INetworkMessage
   {
      
      public function ExchangeMountStableBornAddMessage() {
         super();
      }
      
      public static const protocolId:uint = 5966;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5966;
      }
      
      public function initExchangeMountStableBornAddMessage(param1:MountClientData=null) : ExchangeMountStableBornAddMessage {
         super.initExchangeMountStableAddMessage(param1);
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
         this.serializeAs_ExchangeMountStableBornAddMessage(param1);
      }
      
      public function serializeAs_ExchangeMountStableBornAddMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeMountStableAddMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeMountStableBornAddMessage(param1);
      }
      
      public function deserializeAs_ExchangeMountStableBornAddMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
