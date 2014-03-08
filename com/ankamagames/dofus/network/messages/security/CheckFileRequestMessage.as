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
      
      public function initCheckFileRequestMessage(param1:String="", param2:uint=0) : CheckFileRequestMessage {
         this.filename = param1;
         this.type = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.filename = "";
         this.type = 0;
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
         this.serializeAs_CheckFileRequestMessage(param1);
      }
      
      public function serializeAs_CheckFileRequestMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.filename);
         param1.writeByte(this.type);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CheckFileRequestMessage(param1);
      }
      
      public function deserializeAs_CheckFileRequestMessage(param1:IDataInput) : void {
         this.filename = param1.readUTF();
         this.type = param1.readByte();
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
