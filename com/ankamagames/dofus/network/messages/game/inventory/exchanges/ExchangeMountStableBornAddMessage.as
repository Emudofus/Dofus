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
      
      public function initExchangeMountStableBornAddMessage(mountDescription:MountClientData = null) : ExchangeMountStableBornAddMessage {
         super.initExchangeMountStableAddMessage(mountDescription);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeMountStableBornAddMessage(output);
      }
      
      public function serializeAs_ExchangeMountStableBornAddMessage(output:IDataOutput) : void {
         super.serializeAs_ExchangeMountStableAddMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMountStableBornAddMessage(input);
      }
      
      public function deserializeAs_ExchangeMountStableBornAddMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
