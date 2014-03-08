package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FriendUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendUpdateMessage() {
         this.friendUpdated = new FriendInformations();
         super();
      }
      
      public static const protocolId:uint = 5924;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var friendUpdated:FriendInformations;
      
      override public function getMessageId() : uint {
         return 5924;
      }
      
      public function initFriendUpdateMessage(friendUpdated:FriendInformations=null) : FriendUpdateMessage {
         this.friendUpdated = friendUpdated;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.friendUpdated = new FriendInformations();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FriendUpdateMessage(output);
      }
      
      public function serializeAs_FriendUpdateMessage(output:IDataOutput) : void {
         output.writeShort(this.friendUpdated.getTypeId());
         this.friendUpdated.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendUpdateMessage(input);
      }
      
      public function deserializeAs_FriendUpdateMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.friendUpdated = ProtocolTypeManager.getInstance(FriendInformations,_id1);
         this.friendUpdated.deserialize(input);
      }
   }
}
