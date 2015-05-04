package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FriendAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendAddedMessage()
      {
         this.friendAdded = new FriendInformations();
         super();
      }
      
      public static const protocolId:uint = 5599;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var friendAdded:FriendInformations;
      
      override public function getMessageId() : uint
      {
         return 5599;
      }
      
      public function initFriendAddedMessage(param1:FriendInformations = null) : FriendAddedMessage
      {
         this.friendAdded = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.friendAdded = new FriendInformations();
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
         this.serializeAs_FriendAddedMessage(param1);
      }
      
      public function serializeAs_FriendAddedMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.friendAdded.getTypeId());
         this.friendAdded.serialize(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_FriendAddedMessage(param1);
      }
      
      public function deserializeAs_FriendAddedMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readUnsignedShort();
         this.friendAdded = ProtocolTypeManager.getInstance(FriendInformations,_loc2_);
         this.friendAdded.deserialize(param1);
      }
   }
}
