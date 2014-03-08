package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class RawDataMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function RawDataMessage() {
         this.content = new ByteArray();
         super();
      }
      
      public static const protocolId:uint = 6253;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var content:ByteArray;
      
      override public function getMessageId() : uint {
         return 6253;
      }
      
      public function initRawDataMessage(param1:ByteArray=null) : RawDataMessage {
         this.content = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.content = new ByteArray();
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
         this.serializeAs_RawDataMessage(param1);
      }
      
      public function serializeAs_RawDataMessage(param1:IDataOutput) : void {
         param1.writeShort(this.content.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.content.length)
         {
            param1.writeByte(this.content[_loc2_]);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_RawDataMessage(param1);
      }
      
      public function deserializeAs_RawDataMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readUnsignedShort();
         param1.readBytes(this.content);
      }
   }
}
