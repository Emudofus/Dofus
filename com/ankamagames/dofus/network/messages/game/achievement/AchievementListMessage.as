package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementRewardable;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AchievementListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementListMessage()
      {
         this.finishedAchievementsIds = new Vector.<uint>();
         this.rewardableAchievements = new Vector.<AchievementRewardable>();
         super();
      }
      
      public static const protocolId:uint = 6205;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var finishedAchievementsIds:Vector.<uint>;
      
      public var rewardableAchievements:Vector.<AchievementRewardable>;
      
      override public function getMessageId() : uint
      {
         return 6205;
      }
      
      public function initAchievementListMessage(param1:Vector.<uint> = null, param2:Vector.<AchievementRewardable> = null) : AchievementListMessage
      {
         this.finishedAchievementsIds = param1;
         this.rewardableAchievements = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.finishedAchievementsIds = new Vector.<uint>();
         this.rewardableAchievements = new Vector.<AchievementRewardable>();
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
         this.serializeAs_AchievementListMessage(param1);
      }
      
      public function serializeAs_AchievementListMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.finishedAchievementsIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.finishedAchievementsIds.length)
         {
            if(this.finishedAchievementsIds[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.finishedAchievementsIds[_loc2_] + ") on element 1 (starting at 1) of finishedAchievementsIds.");
            }
            else
            {
               param1.writeVarShort(this.finishedAchievementsIds[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.rewardableAchievements.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.rewardableAchievements.length)
         {
            (this.rewardableAchievements[_loc3_] as AchievementRewardable).serializeAs_AchievementRewardable(param1);
            _loc3_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementListMessage(param1);
      }
      
      public function deserializeAs_AchievementListMessage(param1:ICustomDataInput) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:AchievementRewardable = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readVarUhShort();
            if(_loc6_ < 0)
            {
               throw new Error("Forbidden value (" + _loc6_ + ") on elements of finishedAchievementsIds.");
            }
            else
            {
               this.finishedAchievementsIds.push(_loc6_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new AchievementRewardable();
            _loc7_.deserialize(param1);
            this.rewardableAchievements.push(_loc7_);
            _loc5_++;
         }
      }
   }
}
