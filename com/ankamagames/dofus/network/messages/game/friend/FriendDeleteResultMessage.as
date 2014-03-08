package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class FriendDeleteResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendDeleteResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5601;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var success:Boolean = false;
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 5601;
      }
      
      public function initFriendDeleteResultMessage(param1:Boolean=false, param2:String="") : FriendDeleteResultMessage {
         this.success = param1;
         this.name = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.success = false;
         this.name = "";
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
         this.serializeAs_FriendDeleteResultMessage(param1);
      }
      
      public function serializeAs_FriendDeleteResultMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.success);
         param1.writeUTF(this.name);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FriendDeleteResultMessage(param1);
      }
      
      public function deserializeAs_FriendDeleteResultMessage(param1:IDataInput) : void {
         this.success = param1.readBoolean();
         this.name = param1.readUTF();
      }
   }
}
