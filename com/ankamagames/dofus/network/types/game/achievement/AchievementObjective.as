package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AchievementObjective extends Object implements INetworkType
    {
        public var id:uint = 0;
        public var maxValue:uint = 0;
        public static const protocolId:uint = 404;

        public function AchievementObjective()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 404;
        }// end function

        public function initAchievementObjective(param1:uint = 0, param2:uint = 0) : AchievementObjective
        {
            this.id = param1;
            this.maxValue = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.id = 0;
            this.maxValue = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AchievementObjective(param1);
            return;
        }// end function

        public function serializeAs_AchievementObjective(param1:IDataOutput) : void
        {
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            if (this.maxValue < 0)
            {
                throw new Error("Forbidden value (" + this.maxValue + ") on element maxValue.");
            }
            param1.writeShort(this.maxValue);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AchievementObjective(param1);
            return;
        }// end function

        public function deserializeAs_AchievementObjective(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of AchievementObjective.id.");
            }
            this.maxValue = param1.readShort();
            if (this.maxValue < 0)
            {
                throw new Error("Forbidden value (" + this.maxValue + ") on element of AchievementObjective.maxValue.");
            }
            return;
        }// end function

    }
}
