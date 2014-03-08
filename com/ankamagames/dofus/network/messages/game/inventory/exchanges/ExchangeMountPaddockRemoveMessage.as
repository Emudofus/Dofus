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
      
      public function initExchangeMountPaddockRemoveMessage(param1:Number=0) : ExchangeMountPaddockRemoveMessage {
         this.mountId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mountId = 0;
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
         this.serializeAs_ExchangeMountPaddockRemoveMessage(param1);
      }
      
      public function serializeAs_ExchangeMountPaddockRemoveMessage(param1:IDataOutput) : void {
         param1.writeDouble(this.mountId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeMountPaddockRemoveMessage(param1);
      }
      
      public function deserializeAs_ExchangeMountPaddockRemoveMessage(param1:IDataInput) : void {
         this.mountId = param1.readDouble();
      }
   }
}
