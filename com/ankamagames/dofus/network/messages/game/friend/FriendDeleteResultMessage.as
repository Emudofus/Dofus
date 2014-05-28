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
      
      public function initFriendDeleteResultMessage(success:Boolean = false, name:String = "") : FriendDeleteResultMessage {
         this.success = success;
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.success = false;
         this.name = "";
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
         this.serializeAs_FriendDeleteResultMessage(output);
      }
      
      public function serializeAs_FriendDeleteResultMessage(output:IDataOutput) : void {
         output.writeBoolean(this.success);
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendDeleteResultMessage(input);
      }
      
      public function deserializeAs_FriendDeleteResultMessage(input:IDataInput) : void {
         this.success = input.readBoolean();
         this.name = input.readUTF();
      }
   }
}
