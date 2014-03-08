package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class FriendGuildWarnOnAchievementCompleteStateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function FriendGuildWarnOnAchievementCompleteStateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6383;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6383;
      }
      
      public function initFriendGuildWarnOnAchievementCompleteStateMessage(enable:Boolean=false) : FriendGuildWarnOnAchievementCompleteStateMessage {
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
         this.serializeAs_FriendGuildWarnOnAchievementCompleteStateMessage(output);
      }
      
      public function serializeAs_FriendGuildWarnOnAchievementCompleteStateMessage(output:IDataOutput) : void {
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FriendGuildWarnOnAchievementCompleteStateMessage(input);
      }
      
      public function deserializeAs_FriendGuildWarnOnAchievementCompleteStateMessage(input:IDataInput) : void {
         this.enable = input.readBoolean();
      }
   }
}
