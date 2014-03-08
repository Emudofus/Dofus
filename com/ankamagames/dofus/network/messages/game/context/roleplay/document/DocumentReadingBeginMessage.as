package com.ankamagames.dofus.network.messages.game.context.roleplay.document
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DocumentReadingBeginMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DocumentReadingBeginMessage() {
         super();
      }
      
      public static const protocolId:uint = 5675;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var documentId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5675;
      }
      
      public function initDocumentReadingBeginMessage(param1:uint=0) : DocumentReadingBeginMessage {
         this.documentId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.documentId = 0;
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
         this.serializeAs_DocumentReadingBeginMessage(param1);
      }
      
      public function serializeAs_DocumentReadingBeginMessage(param1:IDataOutput) : void {
         if(this.documentId < 0)
         {
            throw new Error("Forbidden value (" + this.documentId + ") on element documentId.");
         }
         else
         {
            param1.writeShort(this.documentId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_DocumentReadingBeginMessage(param1);
      }
      
      public function deserializeAs_DocumentReadingBeginMessage(param1:IDataInput) : void {
         this.documentId = param1.readShort();
         if(this.documentId < 0)
         {
            throw new Error("Forbidden value (" + this.documentId + ") on element of DocumentReadingBeginMessage.documentId.");
         }
         else
         {
            return;
         }
      }
   }
}
