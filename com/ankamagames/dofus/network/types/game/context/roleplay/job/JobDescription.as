package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescription;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class JobDescription implements INetworkType 
    {

        public static const protocolId:uint = 101;

        public var jobId:uint = 0;
        public var skills:Vector.<SkillActionDescription>;

        public function JobDescription()
        {
            this.skills = new Vector.<SkillActionDescription>();
            super();
        }

        public function getTypeId():uint
        {
            return (101);
        }

        public function initJobDescription(jobId:uint=0, skills:Vector.<SkillActionDescription>=null):JobDescription
        {
            this.jobId = jobId;
            this.skills = skills;
            return (this);
        }

        public function reset():void
        {
            this.jobId = 0;
            this.skills = new Vector.<SkillActionDescription>();
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_JobDescription(output);
        }

        public function serializeAs_JobDescription(output:IDataOutput):void
        {
            if (this.jobId < 0)
            {
                throw (new Error((("Forbidden value (" + this.jobId) + ") on element jobId.")));
            };
            output.writeByte(this.jobId);
            output.writeShort(this.skills.length);
            var _i2:uint;
            while (_i2 < this.skills.length)
            {
                output.writeShort((this.skills[_i2] as SkillActionDescription).getTypeId());
                (this.skills[_i2] as SkillActionDescription).serialize(output);
                _i2++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_JobDescription(input);
        }

        public function deserializeAs_JobDescription(input:IDataInput):void
        {
            var _id2:uint;
            var _item2:SkillActionDescription;
            this.jobId = input.readByte();
            if (this.jobId < 0)
            {
                throw (new Error((("Forbidden value (" + this.jobId) + ") on element of JobDescription.jobId.")));
            };
            var _skillsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _skillsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(SkillActionDescription, _id2);
                _item2.deserialize(input);
                this.skills.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.job

