package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class SkillActionDescription implements INetworkType 
    {

        public static const protocolId:uint = 102;

        public var skillId:uint = 0;


        public function getTypeId():uint
        {
            return (102);
        }

        public function initSkillActionDescription(skillId:uint=0):SkillActionDescription
        {
            this.skillId = skillId;
            return (this);
        }

        public function reset():void
        {
            this.skillId = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_SkillActionDescription(output);
        }

        public function serializeAs_SkillActionDescription(output:ICustomDataOutput):void
        {
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element skillId.")));
            };
            output.writeVarShort(this.skillId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SkillActionDescription(input);
        }

        public function deserializeAs_SkillActionDescription(input:ICustomDataInput):void
        {
            this.skillId = input.readVarUhShort();
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element of SkillActionDescription.skillId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.interactive.skill

