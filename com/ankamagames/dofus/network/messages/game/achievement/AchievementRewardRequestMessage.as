package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementRewardRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementRewardRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6377;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var achievementId:int = 0;
      
      override public function getMessageId() : uint {
         return 6377;
      }
      
      public function initAchievementRewardRequestMessage(param1:int=0) : AchievementRewardRequestMessage {
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
         this.serializeAs_AchievementRewardRequestMessage(param1);
      }
      
      public function serializeAs_AchievementRewardRequestMessage(param1:IDataOutput) : void {
         param1.writeShort(this.achievementId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AchievementRewardRequestMessage(param1);
      }
      
      public function deserializeAs_AchievementRewardRequestMessage(param1:IDataInput) : void {
         this.achievementId = param1.readShort();
      }
   }
}
