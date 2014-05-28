package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementRewardSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementRewardSuccessMessage() {
         super();
      }
      
      public static const protocolId:uint = 6376;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var achievementId:int = 0;
      
      override public function getMessageId() : uint {
         return 6376;
      }
      
      public function initAchievementRewardSuccessMessage(achievementId:int = 0) : AchievementRewardSuccessMessage {
         this.achievementId = achievementId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.achievementId = 0;
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
         this.serializeAs_AchievementRewardSuccessMessage(output);
      }
      
      public function serializeAs_AchievementRewardSuccessMessage(output:IDataOutput) : void {
         output.writeShort(this.achievementId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementRewardSuccessMessage(input);
      }
      
      public function deserializeAs_AchievementRewardSuccessMessage(input:IDataInput) : void {
         this.achievementId = input.readShort();
      }
   }
}
