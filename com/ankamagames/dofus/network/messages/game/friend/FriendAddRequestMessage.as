package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class FriendAddRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendAddRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 4004;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      override public function getMessageId() : uint {
         return 4004;
      }
      
      public function initFriendAddRequestMessage(name:String="") : FriendAddRequestMessage {
         this.name = name;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_FriendAddRequestMessage(output);
      }
      
      public function serializeAs_FriendAddRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendAddRequestMessage(input);
      }
      
      public function deserializeAs_FriendAddRequestMessage(input:IDataInput) : void {
         this.name = input.readUTF();
      }
   }
}
