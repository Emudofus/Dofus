package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class FriendDeleteRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendDeleteRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5603;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accountId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5603;
      }
      
      public function initFriendDeleteRequestMessage(param1:uint=0) : FriendDeleteRequestMessage {
         this.accountId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accountId = 0;
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
         this.serializeAs_FriendDeleteRequestMessage(param1);
      }
      
      public function serializeAs_FriendDeleteRequestMessage(param1:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FriendDeleteRequestMessage(param1);
      }
      
      public function deserializeAs_FriendDeleteRequestMessage(param1:IDataInput) : void {
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of FriendDeleteRequestMessage.accountId.");
         }
         else
         {
            return;
         }
      }
   }
}
