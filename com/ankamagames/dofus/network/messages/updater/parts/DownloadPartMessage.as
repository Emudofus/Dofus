package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class DownloadPartMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DownloadPartMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 1503;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var id:String = "";
      
      override public function getMessageId() : uint
      {
         return 1503;
      }
      
      public function initDownloadPartMessage(param1:String = "") : DownloadPartMessage
      {
         this.id = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_DownloadPartMessage(param1);
      }
      
      public function serializeAs_DownloadPartMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.id);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_DownloadPartMessage(param1);
      }
      
      public function deserializeAs_DownloadPartMessage(param1:ICustomDataInput) : void
      {
         this.id = param1.readUTF();
      }
   }
}
