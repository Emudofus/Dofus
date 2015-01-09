package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementObjective implements INetworkType 
    {

        public static const protocolId:uint = 404;

        public var id:uint = 0;
        public var maxValue:uint = 0;


        public function getTypeId():uint
        {
            return (404);
        }

        public function initAchievementObjective(id:uint=0, maxValue:uint=0):AchievementObjective
        {
            this.id = id;
            this.maxValue = maxValue;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
            this.maxValue = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AchievementObjective(output);
        }

        public function serializeAs_AchievementObjective(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarInt(this.id);
            if (this.maxValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxValue) + ") on element maxValue.")));
            };
            output.writeVarShort(this.maxValue);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementObjective(input);
        }

        public function deserializeAs_AchievementObjective(input:ICustomDataInput):void
        {
            this.id = input.readVarUhInt();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of AchievementObjective.id.")));
            };
            this.maxValue = input.readVarUhShort();
            if (this.maxValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxValue) + ") on element of AchievementObjective.maxValue.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.achievement

