package com.ankamagames.dofus.network.messages.security
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CheckFileMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CheckFileMessage() {
         super();
      }
      
      public static const protocolId:uint = 6156;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var filenameHash:String = "";
      
      public var type:uint = 0;
      
      public var value:String = "";
      
      override public function getMessageId() : uint {
         return 6156;
      }
      
      public function initCheckFileMessage(filenameHash:String = "", type:uint = 0, value:String = "") : CheckFileMessage {
         this.filenameHash = filenameHash;
         this.type = type;
         this.value = value;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.filenameHash = "";
         this.type = 0;
         this.value = "";
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
         this.serializeAs_CheckFileMessage(output);
      }
      
      public function serializeAs_CheckFileMessage(output:IDataOutput) : void {
         output.writeUTF(this.filenameHash);
         output.writeByte(this.type);
         output.writeUTF(this.value);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CheckFileMessage(input);
      }
      
      public function deserializeAs_CheckFileMessage(input:IDataInput) : void {
         this.filenameHash = input.readUTF();
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CheckFileMessage.type.");
         }
         else
         {
            this.value = input.readUTF();
            return;
         }
      }
   }
}
