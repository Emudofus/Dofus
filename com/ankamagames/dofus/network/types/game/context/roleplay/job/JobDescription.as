package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.interactive.skill.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobDescription extends Object implements INetworkType
    {
        public var jobId:uint = 0;
        public var skills:Vector.<SkillActionDescription>;
        public static const protocolId:uint = 101;

        public function JobDescription()
        {
            this.skills = new Vector.<SkillActionDescription>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 101;
        }// end function

        public function initJobDescription(param1:uint = 0, param2:Vector.<SkillActionDescription> = null) : JobDescription
        {
            this.jobId = param1;
            this.skills = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.jobId = 0;
            this.skills = new Vector.<SkillActionDescription>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_JobDescription(param1);
            return;
        }// end function

        public function serializeAs_JobDescription(param1:IDataOutput) : void
        {
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
            }
            param1.writeByte(this.jobId);
            param1.writeShort(this.skills.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.skills.length)
            {
                
                param1.writeShort((this.skills[_loc_2] as SkillActionDescription).getTypeId());
                (this.skills[_loc_2] as SkillActionDescription).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobDescription(param1);
            return;
        }// end function

        public function deserializeAs_JobDescription(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:SkillActionDescription = null;
            this.jobId = param1.readByte();
            if (this.jobId < 0)
            {
                throw new Error("Forbidden value (" + this.jobId + ") on element of JobDescription.jobId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(SkillActionDescription, _loc_4);
                _loc_5.deserialize(param1);
                this.skills.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
