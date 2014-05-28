package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeMountPaddockRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeMountPaddockRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 6050;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mountId:Number = 0;
      
      override public function getMessageId() : uint {
         return 6050;
      }
      
      public function initExchangeMountPaddockRemoveMessage(mountId:Number = 0) : ExchangeMountPaddockRemoveMessage {
         this.mountId = mountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountId = 0;
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
         this.serializeAs_ExchangeMountPaddockRemoveMessage(output);
      }
      
      public function serializeAs_ExchangeMountPaddockRemoveMessage(output:IDataOutput) : void {
         output.writeDouble(this.mountId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeMountPaddockRemoveMessage(input);
      }
      
      public function deserializeAs_ExchangeMountPaddockRemoveMessage(input:IDataInput) : void {
         this.mountId = input.readDouble();
      }
   }
}
