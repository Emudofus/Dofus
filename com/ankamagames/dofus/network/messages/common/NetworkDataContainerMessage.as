package com.ankamagames.dofus.network.messages.common
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.INetworkDataContainerMessage;
   import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class NetworkDataContainerMessage extends NetworkMessage implements INetworkMessage, INetworkDataContainerMessage
   {
      
      public function NetworkDataContainerMessage() {
         super();
      }
      
      public static const protocolId:uint = 2;
      
      private var _content:ByteArray;
      
      private var _isInitialized:Boolean = false;
      
      public function get content() : ByteArray {
         return this._content;
      }
      
      public function set content(value:ByteArray) : void {
         this._content = value;
      }
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint {
         return 2;
      }
      
      public function initNetworkDataContainerMessage(content:ByteArray = null) : NetworkDataContainerMessage {
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
         this.serializeAs_NetworkDataContainerMessage(output);
      }
      
      public function serializeAs_NetworkDataContainerMessage(output:IDataOutput) : void {
         output.writeBytes(this.content);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NetworkDataContainerMessage(input);
      }
      
      public function deserializeAs_NetworkDataContainerMessage(input:IDataInput) : void {
         var _contentLen:uint = input.readUnsignedShort();
         var tmpBuffer:ByteArray = new ByteArray();
         input.readBytes(tmpBuffer);
         tmpBuffer.uncompress();
         this.content = tmpBuffer;
      }
   }
}
