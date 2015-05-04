package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FriendSpouseFollowWithCompassRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendSpouseFollowWithCompassRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5606;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 5606;
      }
      
      public function initFriendSpouseFollowWithCompassRequestMessage(param1:Boolean = false) : FriendSpouseFollowWithCompassRequestMessage
      {
         this.enable = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enable = false;
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
         this.serializeAs_FriendSpouseFollowWithCompassRequestMessage(param1);
      }
      
      public function serializeAs_FriendSpouseFollowWithCompassRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.enable);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FriendSpouseFollowWithCompassRequestMessage(param1);
      }
      
      public function deserializeAs_FriendSpouseFollowWithCompassRequestMessage(param1:ICustomDataInput) : void
      {
         this.enable = param1.readBoolean();
      }
   }
}
