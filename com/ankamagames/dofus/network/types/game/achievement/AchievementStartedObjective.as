package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementStartedObjective extends AchievementObjective implements INetworkType 
    {

        public static const protocolId:uint = 402;

        public var value:uint = 0;


        override public function getTypeId():uint
        {
            return (402);
        }

        public function initAchievementStartedObjective(id:uint=0, maxValue:uint=0, value:uint=0):AchievementStartedObjective
        {
            super.initAchievementObjective(id, maxValue);
            this.value = value;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.value = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AchievementStartedObjective(output);
        }

        public function serializeAs_AchievementStartedObjective(output:ICustomDataOutput):void
        {
            super.serializeAs_AchievementObjective(output);
            if (this.value < 0)
            {
                throw (new Error((("Forbidden value (" + this.value) + ") on element value.")));
            };
            output.writeVarShort(this.value);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementStartedObjective(input);
        }

        public function deserializeAs_AchievementStartedObjective(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.value = input.readVarUhShort();
            if (this.value < 0)
            {
                throw (new Error((("Forbidden value (" + this.value) + ") on element of AchievementStartedObjective.value.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.achievement

