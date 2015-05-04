package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AchievementDetailsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementDetailsRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6380;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var achievementId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6380;
      }
      
      public function initAchievementDetailsRequestMessage(param1:uint = 0) : AchievementDetailsRequestMessage
      {
         this.achievementId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.achievementId = 0;
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
         this.serializeAs_AchievementDetailsRequestMessage(param1);
      }
      
      public function serializeAs_AchievementDetailsRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.achievementId < 0)
         {
            throw new Error("Forbidden value (" + this.achievementId + ") on element achievementId.");
         }
         else
         {
            param1.writeVarShort(this.achievementId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementDetailsRequestMessage(param1);
      }
      
      public function deserializeAs_AchievementDetailsRequestMessage(param1:ICustomDataInput) : void
      {
         this.achievementId = param1.readVarUhShort();
         if(this.achievementId < 0)
         {
            throw new Error("Forbidden value (" + this.achievementId + ") on element of AchievementDetailsRequestMessage.achievementId.");
         }
         else
         {
            return;
         }
      }
   }
}
