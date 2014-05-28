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
      
      public function initRawDataMessage(content:ByteArray = null) : RawDataMessage {
         this.content = content;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.content = new ByteArray();
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
         this.serializeAs_RawDataMessage(output);
      }
      
      public function serializeAs_RawDataMessage(output:IDataOutput) : void {
         output.writeShort(this.content.length);
         var _i1:uint = 0;
         while(_i1 < this.content.length)
         {
            output.writeByte(this.content[_i1]);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_RawDataMessage(input);
      }
      
      public function deserializeAs_RawDataMessage(input:IDataInput) : void {
         var _contentLen:uint = input.readUnsignedShort();
         input.readBytes(this.content);
      }
   }
}
