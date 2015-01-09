package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class Achievement implements INetworkType 
    {

        public static const protocolId:uint = 363;

        public var id:uint = 0;
        public var finishedObjective:Vector.<AchievementObjective>;
        public var startedObjectives:Vector.<AchievementStartedObjective>;

        public function Achievement()
        {
            this.finishedObjective = new Vector.<AchievementObjective>();
            this.startedObjectives = new Vector.<AchievementStartedObjective>();
            super();
        }

        public function getTypeId():uint
        {
            return (363);
        }

        public function initAchievement(id:uint=0, finishedObjective:Vector.<AchievementObjective>=null, startedObjectives:Vector.<AchievementStartedObjective>=null):Achievement
        {
            this.id = id;
            this.finishedObjective = finishedObjective;
            this.startedObjectives = startedObjectives;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
            this.finishedObjective = new Vector.<AchievementObjective>();
            this.startedObjectives = new Vector.<AchievementStartedObjective>();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_Achievement(output);
        }

        public function serializeAs_Achievement(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarShort(this.id);
            output.writeShort(this.finishedObjective.length);
            var _i2:uint;
            while (_i2 < this.finishedObjective.length)
            {
                (this.finishedObjective[_i2] as AchievementObjective).serializeAs_AchievementObjective(output);
                _i2++;
            };
            output.writeShort(this.startedObjectives.length);
            var _i3:uint;
            while (_i3 < this.startedObjectives.length)
            {
                (this.startedObjectives[_i3] as AchievementStartedObjective).serializeAs_AchievementStartedObjective(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_Achievement(input);
        }

        public function deserializeAs_Achievement(input:ICustomDataInput):void
        {
            var _item2:AchievementObjective;
            var _item3:AchievementStartedObjective;
            this.id = input.readVarUhShort();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of Achievement.id.")));
            };
            var _finishedObjectiveLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _finishedObjectiveLen)
            {
                _item2 = new AchievementObjective();
                _item2.deserialize(input);
                this.finishedObjective.push(_item2);
                _i2++;
            };
            var _startedObjectivesLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _startedObjectivesLen)
            {
                _item3 = new AchievementStartedObjective();
                _item3.deserialize(input);
                this.startedObjectives.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.achievement

