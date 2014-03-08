package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FriendsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendsListMessage() {
         this.friendsList = new Vector.<FriendInformations>();
         super();
      }
      
      public static const protocolId:uint = 4002;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var friendsList:Vector.<FriendInformations>;
      
      override public function getMessageId() : uint {
         return 4002;
      }
      
      public function initFriendsListMessage(param1:Vector.<FriendInformations>=null) : FriendsListMessage {
         this.friendsList = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.friendsList = new Vector.<FriendInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FriendsListMessage(param1);
      }
      
      public function serializeAs_FriendsListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.friendsList.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.friendsList.length)
         {
            param1.writeShort((this.friendsList[_loc2_] as FriendInformations).getTypeId());
            (this.friendsList[_loc2_] as FriendInformations).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FriendsListMessage(param1);
      }
      
      public function deserializeAs_FriendsListMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:FriendInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(FriendInformations,_loc4_);
            _loc5_.deserialize(param1);
            this.friendsList.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
