package com.ankamagames.dofus.network.messages.web.krosmaster
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KrosmasterTransferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KrosmasterTransferMessage() {
         super();
      }
      
      public static const protocolId:uint = 6348;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var uid:String = "";
      
      public var failure:uint = 0;
      
      override public function getMessageId() : uint {
         return 6348;
      }
      
      public function initKrosmasterTransferMessage(uid:String="", failure:uint=0) : KrosmasterTransferMessage {
         this.uid = uid;
         this.failure = failure;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.uid = "";
         this.failure = 0;
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
         this.serializeAs_KrosmasterTransferMessage(output);
      }
      
      public function serializeAs_KrosmasterTransferMessage(output:IDataOutput) : void {
         output.writeUTF(this.uid);
         output.writeByte(this.failure);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KrosmasterTransferMessage(input);
      }
      
      public function deserializeAs_KrosmasterTransferMessage(input:IDataInput) : void {
         this.uid = input.readUTF();
         this.failure = input.readByte();
         if(this.failure < 0)
         {
            throw new Error("Forbidden value (" + this.failure + ") on element of KrosmasterTransferMessage.failure.");
         }
         else
         {
            return;
         }
      }
   }
}
