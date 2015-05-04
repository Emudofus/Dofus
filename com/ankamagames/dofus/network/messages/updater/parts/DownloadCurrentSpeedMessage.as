package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class DownloadCurrentSpeedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DownloadCurrentSpeedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 1511;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var downloadSpeed:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 1511;
      }
      
      public function initDownloadCurrentSpeedMessage(param1:uint = 0) : DownloadCurrentSpeedMessage
      {
         this.downloadSpeed = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.downloadSpeed = 0;
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
         this.serializeAs_DownloadCurrentSpeedMessage(param1);
      }
      
      public function serializeAs_DownloadCurrentSpeedMessage(param1:ICustomDataOutput) : void
      {
         if(this.downloadSpeed < 1 || this.downloadSpeed > 10)
         {
            throw new Error("Forbidden value (" + this.downloadSpeed + ") on element downloadSpeed.");
         }
         else
         {
            param1.writeByte(this.downloadSpeed);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_DownloadCurrentSpeedMessage(param1);
      }
      
      public function deserializeAs_DownloadCurrentSpeedMessage(param1:ICustomDataInput) : void
      {
         this.downloadSpeed = param1.readByte();
         if(this.downloadSpeed < 1 || this.downloadSpeed > 10)
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
