package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeHandleMountStableMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeHandleMountStableMessage() {
         super();
      }
      
      public static const protocolId:uint = 5965;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var actionType:int = 0;
      
      public var rideId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5965;
      }
      
      public function initExchangeHandleMountStableMessage(param1:int=0, param2:uint=0) : ExchangeHandleMountStableMessage {
         this.actionType = param1;
         this.rideId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.actionType = 0;
         this.rideId = 0;
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
         this.serializeAs_ExchangeHandleMountStableMessage(param1);
      }
      
      public function serializeAs_ExchangeHandleMountStableMessage(param1:IDataOutput) : void {
         param1.writeByte(this.actionType);
         if(this.rideId < 0)
         {
            throw new Error("Forbidden value (" + this.rideId + ") on element rideId.");
         }
         else
         {
            param1.writeInt(this.rideId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeHandleMountStableMessage(param1);
      }
      
      public function deserializeAs_ExchangeHandleMountStableMessage(param1:IDataInput) : void {
         this.actionType = param1.readByte();
         this.rideId = param1.readInt();
         if(this.rideId < 0)
         {
            throw new Error("Forbidden value (" + this.rideId + ") on element of ExchangeHandleMountStableMessage.rideId.");
         }
         else
         {
            return;
         }
      }
   }
}
