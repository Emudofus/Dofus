package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SkillActionDescriptionTimed extends SkillActionDescription implements INetworkType
    {
        public var time:uint = 0;
        public static const protocolId:uint = 103;

        public function SkillActionDescriptionTimed()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 103;
        }// end function

        public function initSkillActionDescriptionTimed(param1:uint = 0, param2:uint = 0) : SkillActionDescriptionTimed
        {
            super.initSkillActionDescription(param1);
            this.time = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.time = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SkillActionDescriptionTimed(param1);
            return;
        }// end function

        public function serializeAs_SkillActionDescriptionTimed(param1:IDataOutput) : void
        {
            super.serializeAs_SkillActionDescription(param1);
            if (this.time < 0 || this.time > 255)
            {
                throw new Error("Forbidden value (" + this.time + ") on element time.");
            }
            param1.writeByte(this.time);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SkillActionDescriptionTimed(param1);
            return;
        }// end function

        public function deserializeAs_SkillActionDescriptionTimed(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.time = param1.readUnsignedByte();
            if (this.time < 0 || this.time > 255)
            {
                throw new Error("Forbidden value (" + this.time + ") on element of SkillActionDescriptionTimed.time.");
            }
            return;
        }// end function

    }
}
