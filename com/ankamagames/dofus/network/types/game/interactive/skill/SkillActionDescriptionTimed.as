package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SkillActionDescriptionTimed extends SkillActionDescription implements INetworkType 
    {

        public static const protocolId:uint = 103;

        public var time:uint = 0;


        override public function getTypeId():uint
        {
            return (103);
        }

        public function initSkillActionDescriptionTimed(skillId:uint=0, time:uint=0):SkillActionDescriptionTimed
        {
            super.initSkillActionDescription(skillId);
            this.time = time;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.time = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_SkillActionDescriptionTimed(output);
        }

        public function serializeAs_SkillActionDescriptionTimed(output:ICustomDataOutput):void
        {
            super.serializeAs_SkillActionDescription(output);
            if ((((this.time < 0)) || ((this.time > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.time) + ") on element time.")));
            };
            output.writeByte(this.time);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SkillActionDescriptionTimed(input);
        }

        public function deserializeAs_SkillActionDescriptionTimed(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.time = input.readUnsignedByte();
            if ((((this.time < 0)) || ((this.time > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.time) + ") on element of SkillActionDescriptionTimed.time.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.interactive.skill

