package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementRewardErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementRewardErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6375;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var achievementId:int = 0;
      
      override public function getMessageId() : uint {
         return 6375;
      }
      
      public function initAchievementRewardErrorMessage(achievementId:int = 0) : AchievementRewardErrorMessage {
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
         this.serializeAs_AchievementRewardErrorMessage(output);
      }
      
      public function serializeAs_AchievementRewardErrorMessage(output:IDataOutput) : void {
         output.writeShort(this.achievementId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementRewardErrorMessage(input);
      }
      
      public function deserializeAs_AchievementRewardErrorMessage(input:IDataInput) : void {
         this.achievementId = input.readShort();
      }
   }
}
