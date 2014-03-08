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
      
      public function initCheckFileMessage(param1:String="", param2:uint=0, param3:String="") : CheckFileMessage {
         this.filenameHash = param1;
         this.type = param2;
         this.value = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.filenameHash = "";
         this.type = 0;
         this.value = "";
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
         this.serializeAs_CheckFileMessage(param1);
      }
      
      public function serializeAs_CheckFileMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.filenameHash);
         param1.writeByte(this.type);
         param1.writeUTF(this.value);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CheckFileMessage(param1);
      }
      
      public function deserializeAs_CheckFileMessage(param1:IDataInput) : void {
         this.filenameHash = param1.readUTF();
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CheckFileMessage.type.");
         }
         else
         {
            this.value = param1.readUTF();
            return;
         }
      }
   }
}
