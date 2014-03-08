package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class OnConnectionEventMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function OnConnectionEventMessage() {
         super();
      }
      
      public static const protocolId:uint = 5726;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var eventType:uint = 0;
      
      override public function getMessageId() : uint {
         return 5726;
      }
      
      public function initOnConnectionEventMessage(eventType:uint=0) : OnConnectionEventMessage {
         this.eventType = eventType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.eventType = 0;
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
         this.serializeAs_OnConnectionEventMessage(output);
      }
      
      public function serializeAs_OnConnectionEventMessage(output:IDataOutput) : void {
         output.writeByte(this.eventType);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_OnConnectionEventMessage(input);
      }
      
      public function deserializeAs_OnConnectionEventMessage(input:IDataInput) : void {
         this.eventType = input.readByte();
         if(this.eventType < 0)
         {
            throw new Error("Forbidden value (" + this.eventType + ") on element of OnConnectionEventMessage.eventType.");
         }
         else
         {
            return;
         }
      }
   }
}
