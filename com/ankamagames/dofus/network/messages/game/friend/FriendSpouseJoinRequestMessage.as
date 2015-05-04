package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class FriendSpouseJoinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendSpouseJoinRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5604;
      
      override public function get isInitialized() : Boolean
      {
         return true;
      }
      
      override public function getMessageId() : uint
      {
         return 5604;
      }
      
      public function initFriendSpouseJoinRequestMessage() : FriendSpouseJoinRequestMessage
      {
         return this;
      }
      
      override public function reset() : void
      {
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
      }
      
      public function serializeAs_FriendSpouseJoinRequestMessage(param1:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_FriendSpouseJoinRequestMessage(param1:ICustomDataInput) : void
      {
      }
   }
}
