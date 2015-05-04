package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MountRidingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MountRidingMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5967;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var isRiding:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5967;
      }
      
      public function initMountRidingMessage(param1:Boolean = false) : MountRidingMessage
      {
         this.isRiding = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isRiding = false;
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
         this.serializeAs_MountRidingMessage(param1);
      }
      
      public function serializeAs_MountRidingMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.isRiding);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MountRidingMessage(param1);
      }
      
      public function deserializeAs_MountRidingMessage(param1:ICustomDataInput) : void
      {
         this.isRiding = param1.readBoolean();
      }
   }
}
