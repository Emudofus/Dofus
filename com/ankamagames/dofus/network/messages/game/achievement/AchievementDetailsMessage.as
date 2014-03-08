package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.achievement.Achievement;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementDetailsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementDetailsMessage() {
         this.achievement = new Achievement();
         super();
      }
      
      public static const protocolId:uint = 6378;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var achievement:Achievement;
      
      override public function getMessageId() : uint {
         return 6378;
      }
      
      public function initAchievementDetailsMessage(achievement:Achievement=null) : AchievementDetailsMessage {
         this.achievement = achievement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.achievement = new Achievement();
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
         this.serializeAs_AchievementDetailsMessage(output);
      }
      
      public function serializeAs_AchievementDetailsMessage(output:IDataOutput) : void {
         this.achievement.serializeAs_Achievement(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementDetailsMessage(input);
      }
      
      public function deserializeAs_AchievementDetailsMessage(input:IDataInput) : void {
         this.achievement = new Achievement();
         this.achievement.deserialize(input);
      }
   }
}
