package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DownloadErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DownloadErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 1513;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var errorId:uint = 0;
      
      public var message:String = "";
      
      public var helpUrl:String = "";
      
      override public function getMessageId() : uint {
         return 1513;
      }
      
      public function initDownloadErrorMessage(errorId:uint=0, message:String="", helpUrl:String="") : DownloadErrorMessage {
         this.errorId = errorId;
         this.message = message;
         this.helpUrl = helpUrl;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.errorId = 0;
         this.message = "";
         this.helpUrl = "";
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
         this.serializeAs_DownloadErrorMessage(output);
      }
      
      public function serializeAs_DownloadErrorMessage(output:IDataOutput) : void {
         output.writeByte(this.errorId);
         output.writeUTF(this.message);
         output.writeUTF(this.helpUrl);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DownloadErrorMessage(input);
      }
      
      public function deserializeAs_DownloadErrorMessage(input:IDataInput) : void {
         this.errorId = input.readByte();
         if(this.errorId < 0)
         {
            throw new Error("Forbidden value (" + this.errorId + ") on element of DownloadErrorMessage.errorId.");
         }
         else
         {
            this.message = input.readUTF();
            this.helpUrl = input.readUTF();
            return;
         }
      }
   }
}
