package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.achievement.Achievement;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementDetailedListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementDetailedListMessage() {
         this.startedAchievements = new Vector.<Achievement>();
         this.finishedAchievements = new Vector.<Achievement>();
         super();
      }
      
      public static const protocolId:uint = 6358;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var startedAchievements:Vector.<Achievement>;
      
      public var finishedAchievements:Vector.<Achievement>;
      
      override public function getMessageId() : uint {
         return 6358;
      }
      
      public function initAchievementDetailedListMessage(param1:Vector.<Achievement>=null, param2:Vector.<Achievement>=null) : AchievementDetailedListMessage {
         this.startedAchievements = param1;
         this.finishedAchievements = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.startedAchievements = new Vector.<Achievement>();
         this.finishedAchievements = new Vector.<Achievement>();
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
         this.serializeAs_AchievementDetailedListMessage(param1);
      }
      
      public function serializeAs_AchievementDetailedListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.startedAchievements.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.startedAchievements.length)
         {
            (this.startedAchievements[_loc2_] as Achievement).serializeAs_Achievement(param1);
            _loc2_++;
         }
         param1.writeShort(this.finishedAchievements.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.finishedAchievements.length)
         {
            (this.finishedAchievements[_loc3_] as Achievement).serializeAs_Achievement(param1);
            _loc3_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AchievementDetailedListMessage(param1);
      }
      
      public function deserializeAs_AchievementDetailedListMessage(param1:IDataInput) : void {
         var _loc6_:Achievement = null;
         var _loc7_:Achievement = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = new Achievement();
            _loc6_.deserialize(param1);
            this.startedAchievements.push(_loc6_);
            _loc3_++;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new Achievement();
            _loc7_.deserialize(param1);
            this.finishedAchievements.push(_loc7_);
            _loc5_++;
         }
      }
   }
}
