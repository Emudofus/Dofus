package com.ankamagames.dofus.network.types.game.achievement
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class Achievement extends Object implements INetworkType
    {
        public var id:uint = 0;
        public var finishedObjective:Vector.<AchievementObjective>;
        public var startedObjectives:Vector.<AchievementStartedObjective>;
        public static const protocolId:uint = 363;

        public function Achievement()
        {
            this.finishedObjective = new Vector.<AchievementObjective>;
            this.startedObjectives = new Vector.<AchievementStartedObjective>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 363;
        }// end function

        public function initAchievement(param1:uint = 0, param2:Vector.<AchievementObjective> = null, param3:Vector.<AchievementStartedObjective> = null) : Achievement
        {
            this.id = param1;
            this.finishedObjective = param2;
            this.startedObjectives = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            this.finishedObjective = new Vector.<AchievementObjective>;
            this.startedObjectives = new Vector.<AchievementStartedObjective>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_Achievement(param1);
            return;
        }// end function

        public function serializeAs_Achievement(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeShort(this.id);
            param1.writeShort(this.finishedObjective.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.finishedObjective.length)
            {
                
                (this.finishedObjective[_loc_2] as AchievementObjective).serializeAs_AchievementObjective(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.startedObjectives.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.startedObjectives.length)
            {
                
                (this.startedObjectives[_loc_3] as AchievementStartedObjective).serializeAs_AchievementStartedObjective(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_Achievement(param1);
            return;
        }// end function

        public function deserializeAs_Achievement(param1:IDataInput) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            this.id = param1.readShort();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of Achievement.id.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new AchievementObjective();
                _loc_6.deserialize(param1);
                this.finishedObjective.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new AchievementStartedObjective();
                _loc_7.deserialize(param1);
                this.startedObjectives.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
