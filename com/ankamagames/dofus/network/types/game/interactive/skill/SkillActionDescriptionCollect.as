package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SkillActionDescriptionCollect extends SkillActionDescriptionTimed implements INetworkType 
    {

        public static const protocolId:uint = 99;

        public var min:uint = 0;
        public var max:uint = 0;


        override public function getTypeId():uint
        {
            return (99);
        }

        public function initSkillActionDescriptionCollect(skillId:uint=0, time:uint=0, min:uint=0, max:uint=0):SkillActionDescriptionCollect
        {
            super.initSkillActionDescriptionTimed(skillId, time);
            this.min = min;
            this.max = max;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.min = 0;
            this.max = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_SkillActionDescriptionCollect(output);
        }

        public function serializeAs_SkillActionDescriptionCollect(output:ICustomDataOutput):void
        {
            super.serializeAs_SkillActionDescriptionTimed(output);
            if (this.min < 0)
            {
                throw (new Error((("Forbidden value (" + this.min) + ") on element min.")));
            };
            output.writeVarShort(this.min);
            if (this.max < 0)
            {
                throw (new Error((("Forbidden value (" + this.max) + ") on element max.")));
            };
            output.writeVarShort(this.max);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SkillActionDescriptionCollect(input);
        }

        public function deserializeAs_SkillActionDescriptionCollect(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.min = input.readVarUhShort();
            if (this.min < 0)
            {
                throw (new Error((("Forbidden value (" + this.min) + ") on element of SkillActionDescriptionCollect.min.")));
            };
            this.max = input.readVarUhShort();
            if (this.max < 0)
            {
                throw (new Error((("Forbidden value (" + this.max) + ") on element of SkillActionDescriptionCollect.max.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.interactive.skill

