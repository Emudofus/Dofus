package com.ankamagames.dofus.network.types.game.achievement
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AchievementRewardable implements INetworkType 
    {

        public static const protocolId:uint = 412;

        public var id:uint = 0;
        public var finishedlevel:uint = 0;


        public function getTypeId():uint
        {
            return (412);
        }

        public function initAchievementRewardable(id:uint=0, finishedlevel:uint=0):AchievementRewardable
        {
            this.id = id;
            this.finishedlevel = finishedlevel;
            return (this);
        }

        public function reset():void
        {
            this.id = 0;
            this.finishedlevel = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AchievementRewardable(output);
        }

        public function serializeAs_AchievementRewardable(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarShort(this.id);
            if ((((this.finishedlevel < 0)) || ((this.finishedlevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.finishedlevel) + ") on element finishedlevel.")));
            };
            output.writeByte(this.finishedlevel);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AchievementRewardable(input);
        }

        public function deserializeAs_AchievementRewardable(input:ICustomDataInput):void
        {
            this.id = input.readVarUhShort();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of AchievementRewardable.id.")));
            };
            this.finishedlevel = input.readUnsignedByte();
            if ((((this.finishedlevel < 0)) || ((this.finishedlevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.finishedlevel) + ") on element of AchievementRewardable.finishedlevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.achievement

