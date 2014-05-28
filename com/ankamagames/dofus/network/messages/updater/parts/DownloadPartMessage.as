package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DownloadPartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DownloadPartMessage() {
         super();
      }
      
      public static const protocolId:uint = 1503;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:String = "";
      
      override public function getMessageId() : uint {
         return 1503;
      }
      
      public function initDownloadPartMessage(id:String = "") : DownloadPartMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = "";
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
         this.serializeAs_DownloadPartMessage(output);
      }
      
      public function serializeAs_DownloadPartMessage(output:IDataOutput) : void {
         output.writeUTF(this.id);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DownloadPartMessage(input);
      }
      
      public function deserializeAs_DownloadPartMessage(input:IDataInput) : void {
         this.id = input.readUTF();
      }
   }
}
