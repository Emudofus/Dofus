package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicTimeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicTimeMessage() {
         super();
      }
      
      public static const protocolId:uint = 175;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var timestamp:uint = 0;
      
      public var timezoneOffset:int = 0;
      
      override public function getMessageId() : uint {
         return 175;
      }
      
      public function initBasicTimeMessage(timestamp:uint=0, timezoneOffset:int=0) : BasicTimeMessage {
         this.timestamp = timestamp;
         this.timezoneOffset = timezoneOffset;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.timestamp = 0;
         this.timezoneOffset = 0;
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
         this.serializeAs_BasicTimeMessage(output);
      }
      
      public function serializeAs_BasicTimeMessage(output:IDataOutput) : void {
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         else
         {
            output.writeInt(this.timestamp);
            output.writeShort(this.timezoneOffset);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicTimeMessage(input);
      }
      
      public function deserializeAs_BasicTimeMessage(input:IDataInput) : void {
         this.timestamp = input.readInt();
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of BasicTimeMessage.timestamp.");
         }
         else
         {
            this.timezoneOffset = input.readShort();
            return;
         }
      }
   }
}
