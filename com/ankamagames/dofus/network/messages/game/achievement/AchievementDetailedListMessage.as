package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initAchievementDetailedListMessage(startedAchievements:Vector.<Achievement> = null, finishedAchievements:Vector.<Achievement> = null) : AchievementDetailedListMessage {
         this.startedAchievements = startedAchievements;
         this.finishedAchievements = finishedAchievements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.startedAchievements = new Vector.<Achievement>();
         this.finishedAchievements = new Vector.<Achievement>();
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
         this.serializeAs_AchievementDetailedListMessage(output);
      }
      
      public function serializeAs_AchievementDetailedListMessage(output:IDataOutput) : void {
         output.writeShort(this.startedAchievements.length);
         var _i1:uint = 0;
         while(_i1 < this.startedAchievements.length)
         {
            (this.startedAchievements[_i1] as Achievement).serializeAs_Achievement(output);
            _i1++;
         }
         output.writeShort(this.finishedAchievements.length);
         var _i2:uint = 0;
         while(_i2 < this.finishedAchievements.length)
         {
            (this.finishedAchievements[_i2] as Achievement).serializeAs_Achievement(output);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementDetailedListMessage(input);
      }
      
      public function deserializeAs_AchievementDetailedListMessage(input:IDataInput) : void {
         var _item1:Achievement = null;
         var _item2:Achievement = null;
         var _startedAchievementsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _startedAchievementsLen)
         {
            _item1 = new Achievement();
            _item1.deserialize(input);
            this.startedAchievements.push(_item1);
            _i1++;
         }
         var _finishedAchievementsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _finishedAchievementsLen)
         {
            _item2 = new Achievement();
            _item2.deserialize(input);
            this.finishedAchievements.push(_item2);
            _i2++;
         }
      }
   }
}
