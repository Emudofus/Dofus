package com.ankamagames.dofus.network.messages.web.krosmaster
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KrosmasterTransferRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KrosmasterTransferRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6349;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var uid:String = "";
      
      override public function getMessageId() : uint {
         return 6349;
      }
      
      public function initKrosmasterTransferRequestMessage(uid:String="") : KrosmasterTransferRequestMessage {
         this.uid = uid;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.uid = "";
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
         this.serializeAs_KrosmasterTransferRequestMessage(output);
      }
      
      public function serializeAs_KrosmasterTransferRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.uid);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KrosmasterTransferRequestMessage(input);
      }
      
      public function deserializeAs_KrosmasterTransferRequestMessage(input:IDataInput) : void {
         this.uid = input.readUTF();
      }
   }
}
