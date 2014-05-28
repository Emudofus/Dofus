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
      
      public function initExchangeHandleMountStableMessage(actionType:int = 0, rideId:uint = 0) : ExchangeHandleMountStableMessage {
         this.actionType = actionType;
         this.rideId = rideId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.actionType = 0;
         this.rideId = 0;
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
         this.serializeAs_ExchangeHandleMountStableMessage(output);
      }
      
      public function serializeAs_ExchangeHandleMountStableMessage(output:IDataOutput) : void {
         output.writeByte(this.actionType);
         if(this.rideId < 0)
         {
            throw new Error("Forbidden value (" + this.rideId + ") on element rideId.");
         }
         else
         {
            output.writeInt(this.rideId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeHandleMountStableMessage(input);
      }
      
      public function deserializeAs_ExchangeHandleMountStableMessage(input:IDataInput) : void {
         this.actionType = input.readByte();
         this.rideId = input.readInt();
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
