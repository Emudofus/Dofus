package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IdentificationFailedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IdentificationFailedMessage() {
         super();
      }
      
      public static const protocolId:uint = 20;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 99;
      
      override public function getMessageId() : uint {
         return 20;
      }
      
      public function initIdentificationFailedMessage(param1:uint=99) : IdentificationFailedMessage {
         this.reason = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 99;
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
         this.serializeAs_IdentificationFailedMessage(param1);
      }
      
      public function serializeAs_IdentificationFailedMessage(param1:IDataOutput) : void {
         param1.writeByte(this.reason);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IdentificationFailedMessage(param1);
      }
      
      public function deserializeAs_IdentificationFailedMessage(param1:IDataInput) : void {
         this.reason = param1.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of IdentificationFailedMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
