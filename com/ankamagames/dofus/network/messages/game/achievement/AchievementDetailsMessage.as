package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.achievement.Achievement;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AchievementDetailsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementDetailsMessage()
      {
         this.achievement = new Achievement();
         super();
      }
      
      public static const protocolId:uint = 6378;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var achievement:Achievement;
      
      override public function getMessageId() : uint
      {
         return 6378;
      }
      
      public function initAchievementDetailsMessage(param1:Achievement = null) : AchievementDetailsMessage
      {
         this.achievement = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.achievement = new Achievement();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementDetailsMessage(param1);
      }
      
      public function serializeAs_AchievementDetailsMessage(param1:ICustomDataOutput) : void
      {
         this.achievement.serializeAs_Achievement(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementDetailsMessage(param1);
      }
      
      public function deserializeAs_AchievementDetailsMessage(param1:ICustomDataInput) : void
      {
         this.achievement = new Achievement();
         this.achievement.deserialize(param1);
      }
   }
}
