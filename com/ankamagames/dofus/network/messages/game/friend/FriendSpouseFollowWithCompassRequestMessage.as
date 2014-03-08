package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class FriendSpouseFollowWithCompassRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendSpouseFollowWithCompassRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5606;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5606;
      }
      
      public function initFriendSpouseFollowWithCompassRequestMessage(enable:Boolean=false) : FriendSpouseFollowWithCompassRequestMessage {
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enable = false;
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
         this.serializeAs_FriendSpouseFollowWithCompassRequestMessage(output);
      }
      
      public function serializeAs_FriendSpouseFollowWithCompassRequestMessage(output:IDataOutput) : void {
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendSpouseFollowWithCompassRequestMessage(input);
      }
      
      public function deserializeAs_FriendSpouseFollowWithCompassRequestMessage(input:IDataInput) : void {
         this.enable = input.readBoolean();
      }
   }
}
