package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class FriendWarnOnLevelGainStateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendWarnOnLevelGainStateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6078;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6078;
      }
      
      public function initFriendWarnOnLevelGainStateMessage(enable:Boolean = false) : FriendWarnOnLevelGainStateMessage {
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
         this.serializeAs_FriendWarnOnLevelGainStateMessage(output);
      }
      
      public function serializeAs_FriendWarnOnLevelGainStateMessage(output:IDataOutput) : void {
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendWarnOnLevelGainStateMessage(input);
      }
      
      public function deserializeAs_FriendWarnOnLevelGainStateMessage(input:IDataInput) : void {
         this.enable = input.readBoolean();
      }
   }
}
