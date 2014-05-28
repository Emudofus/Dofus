package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CheckFileRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CheckFileRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6154;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var filename:String = "";
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint {
         return 6154;
      }
      
      public function initCheckFileRequestMessage(filename:String = "", type:uint = 0) : CheckFileRequestMessage {
         this.filename = filename;
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.filename = "";
         this.type = 0;
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
         this.serializeAs_CheckFileRequestMessage(output);
      }
      
      public function serializeAs_CheckFileRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.filename);
         output.writeByte(this.type);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CheckFileRequestMessage(input);
      }
      
      public function deserializeAs_CheckFileRequestMessage(input:IDataInput) : void {
         this.filename = input.readUTF();
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CheckFileRequestMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
