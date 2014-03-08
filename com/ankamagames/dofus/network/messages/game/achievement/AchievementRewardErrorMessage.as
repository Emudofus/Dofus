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
      
      public function initAchievementRewardErrorMessage(param1:int=0) : AchievementRewardErrorMessage {
         this.achievementId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.achievementId = 0;
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
         this.serializeAs_AchievementRewardErrorMessage(param1);
      }
      
      public function serializeAs_AchievementRewardErrorMessage(param1:IDataOutput) : void {
         param1.writeShort(this.achievementId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AchievementRewardErrorMessage(param1);
      }
      
      public function deserializeAs_AchievementRewardErrorMessage(param1:IDataInput) : void {
         this.achievementId = param1.readShort();
      }
   }
}
