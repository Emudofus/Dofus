package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountXpRatioMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountXpRatioMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5970;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var ratio:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5970;
      }
      
      public function initMountXpRatioMessage(param1:uint = 0) : MountXpRatioMessage
      {
         this.ratio = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ratio = 0;
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
         this.serializeAs_MountXpRatioMessage(param1);
      }
      
      public function serializeAs_MountXpRatioMessage(param1:ICustomDataOutput) : void
      {
         if(this.ratio < 0)
         {
            throw new Error("Forbidden value (" + this.ratio + ") on element ratio.");
         }
         else
         {
            param1.writeByte(this.ratio);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountXpRatioMessage(param1);
      }
      
      public function deserializeAs_MountXpRatioMessage(param1:ICustomDataInput) : void
      {
         this.ratio = param1.readByte();
         if(this.ratio < 0)
         {
            throw new Error("Forbidden value (" + this.ratio + ") on element of MountXpRatioMessage.ratio.");
         }
         else
         {
            return;
         }
      }
   }
}
