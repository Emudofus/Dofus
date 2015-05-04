package com.ankamagames.dofus.network.messages.updater.parts
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PartInfoMessage()
      {
         this.part = new ContentPart();
         super();
      }
      
      public static const protocolId:uint = 1508;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var part:ContentPart;
      
      public var installationPercent:Number = 0;
      
      override public function getMessageId() : uint
      {
         return 1508;
      }
      
      public function initPartInfoMessage(param1:ContentPart = null, param2:Number = 0) : PartInfoMessage
      {
         this.part = param1;
         this.installationPercent = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.part = new ContentPart();
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
         this.serializeAs_PartInfoMessage(param1);
      }
      
      public function serializeAs_PartInfoMessage(param1:ICustomDataOutput) : void
      {
         this.part.serializeAs_ContentPart(param1);
         param1.writeFloat(this.installationPercent);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartInfoMessage(param1);
      }
      
      public function deserializeAs_PartInfoMessage(param1:ICustomDataInput) : void
      {
         this.part = new ContentPart();
         this.part.deserialize(param1);
         this.installationPercent = param1.readFloat();
      }
   }
}
