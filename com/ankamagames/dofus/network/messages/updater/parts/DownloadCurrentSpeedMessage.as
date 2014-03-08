package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DownloadCurrentSpeedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DownloadCurrentSpeedMessage() {
         super();
      }
      
      public static const protocolId:uint = 1511;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var downloadSpeed:uint = 0;
      
      override public function getMessageId() : uint {
         return 1511;
      }
      
      public function initDownloadCurrentSpeedMessage(downloadSpeed:uint=0) : DownloadCurrentSpeedMessage {
         this.downloadSpeed = downloadSpeed;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.downloadSpeed = 0;
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
         this.serializeAs_DownloadCurrentSpeedMessage(output);
      }
      
      public function serializeAs_DownloadCurrentSpeedMessage(output:IDataOutput) : void {
         if((this.downloadSpeed < 1) || (this.downloadSpeed > 10))
         {
            throw new Error("Forbidden value (" + this.downloadSpeed + ") on element downloadSpeed.");
         }
         else
         {
            output.writeByte(this.downloadSpeed);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DownloadCurrentSpeedMessage(input);
      }
      
      public function deserializeAs_DownloadCurrentSpeedMessage(input:IDataInput) : void {
         this.downloadSpeed = input.readByte();
         if((this.downloadSpeed < 1) || (this.downloadSpeed > 10))
         {
            throw new Error("Forbidden value (" + this.downloadSpeed + ") on element of DownloadCurrentSpeedMessage.downloadSpeed.");
         }
         else
         {
            return;
         }
      }
   }
}
