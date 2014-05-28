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
      
      public function initDocumentReadingBeginMessage(documentId:uint = 0) : DocumentReadingBeginMessage {
         this.documentId = documentId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.documentId = 0;
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
         this.serializeAs_DocumentReadingBeginMessage(output);
      }
      
      public function serializeAs_DocumentReadingBeginMessage(output:IDataOutput) : void {
         if(this.documentId < 0)
         {
            throw new Error("Forbidden value (" + this.documentId + ") on element documentId.");
         }
         else
         {
            output.writeShort(this.documentId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DocumentReadingBeginMessage(input);
      }
      
      public function deserializeAs_DocumentReadingBeginMessage(input:IDataInput) : void {
         this.documentId = input.readShort();
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
