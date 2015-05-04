package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountSetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountSetMessage()
      {
         this.mountData = new MountClientData();
         super();
      }
      
      public static const protocolId:uint = 5968;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var mountData:MountClientData;
      
      override public function getMessageId() : uint
      {
         return 5968;
      }
      
      public function initMountSetMessage(param1:MountClientData = null) : MountSetMessage
      {
         this.mountData = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountData = new MountClientData();
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
         this.serializeAs_MountSetMessage(param1);
      }
      
      public function serializeAs_MountSetMessage(param1:ICustomDataOutput) : void
      {
         this.mountData.serializeAs_MountClientData(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountSetMessage(param1);
      }
      
      public function deserializeAs_MountSetMessage(param1:ICustomDataInput) : void
      {
         this.mountData = new MountClientData();
         this.mountData.deserialize(param1);
      }
   }
}
