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
      
      public function initKrosmasterTransferRequestMessage(param1:String="") : KrosmasterTransferRequestMessage {
         this.uid = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.uid = "";
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
         this.serializeAs_KrosmasterTransferRequestMessage(param1);
      }
      
      public function serializeAs_KrosmasterTransferRequestMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.uid);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_KrosmasterTransferRequestMessage(param1);
      }
      
      public function deserializeAs_KrosmasterTransferRequestMessage(param1:IDataInput) : void {
         this.uid = param1.readUTF();
      }
   }
}
