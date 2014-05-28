package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DownloadSetSpeedRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DownloadSetSpeedRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 1512;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var downloadSpeed:uint = 0;
      
      override public function getMessageId() : uint {
         return 1512;
      }
      
      public function initDownloadSetSpeedRequestMessage(downloadSpeed:uint = 0) : DownloadSetSpeedRequestMessage {
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
         this.serializeAs_DownloadSetSpeedRequestMessage(output);
      }
      
      public function serializeAs_DownloadSetSpeedRequestMessage(output:IDataOutput) : void {
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
         this.deserializeAs_DownloadSetSpeedRequestMessage(input);
      }
      
      public function deserializeAs_DownloadSetSpeedRequestMessage(input:IDataInput) : void {
         this.downloadSpeed = input.readByte();
         if((this.downloadSpeed < 1) || (this.downloadSpeed > 10))
         {
            throw new Error("Forbidden value (" + this.downloadSpeed + ") on element of DownloadSetSpeedRequestMessage.downloadSpeed.");
         }
         else
         {
            return;
         }
      }
   }
}
