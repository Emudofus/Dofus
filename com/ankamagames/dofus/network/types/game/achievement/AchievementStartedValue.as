package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementStartedValue extends Achievement implements INetworkType
    {
        public var value:uint = 0;
        public var maxValue:uint = 0;
        public static const protocolId:uint = 361;

        public function AchievementStartedValue()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 361;
        }// end function

        public function initAchievementStartedValue(param1:uint = 0, param2:uint = 0, param3:uint = 0) : AchievementStartedValue
        {
            super.initAchievement(param1);
            this.value = param2;
            this.maxValue = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.value = 0;
            this.maxValue = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AchievementStartedValue(param1);
            return;
        }// end function

        public function serializeAs_AchievementStartedValue(param1:IDataOutput) : void
        {
            super.serializeAs_Achievement(param1);
            if (this.value < 0)
            {
                throw new Error("Forbidden value (" + this.value + ") on element value.");
            }
            param1.writeShort(this.value);
            if (this.maxValue < 0)
            {
                throw new Error("Forbidden value (" + this.maxValue + ") on element maxValue.");
            }
            param1.writeShort(this.maxValue);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementStartedValue(param1);
            return;
        }// end function

        public function deserializeAs_AchievementStartedValue(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.value = param1.readShort();
            if (this.value < 0)
            {
                throw new Error("Forbidden value (" + this.value + ") on element of AchievementStartedValue.value.");
            }
            this.maxValue = param1.readShort();
            if (this.maxValue < 0)
            {
                throw new Error("Forbidden value (" + this.maxValue + ") on element of AchievementStartedValue.maxValue.");
            }
            return;
        }// end function

    }
}
