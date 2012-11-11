package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SkillActionDescriptionCollect extends SkillActionDescriptionTimed implements INetworkType
    {
        public var min:uint = 0;
        public var max:uint = 0;
        public static const protocolId:uint = 99;

        public function SkillActionDescriptionCollect()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 99;
        }// end function

        public function initSkillActionDescriptionCollect(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : SkillActionDescriptionCollect
        {
            super.initSkillActionDescriptionTimed(param1, param2);
            this.min = param3;
            this.max = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.min = 0;
            this.max = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SkillActionDescriptionCollect(param1);
            return;
        }// end function

        public function serializeAs_SkillActionDescriptionCollect(param1:IDataOutput) : void
        {
            super.serializeAs_SkillActionDescriptionTimed(param1);
            if (this.min < 0)
            {
                throw new Error("Forbidden value (" + this.min + ") on element min.");
            }
            param1.writeShort(this.min);
            if (this.max < 0)
            {
                throw new Error("Forbidden value (" + this.max + ") on element max.");
            }
            param1.writeShort(this.max);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SkillActionDescriptionCollect(param1);
            return;
        }// end function

        public function deserializeAs_SkillActionDescriptionCollect(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.min = param1.readShort();
            if (this.min < 0)
            {
                throw new Error("Forbidden value (" + this.min + ") on element of SkillActionDescriptionCollect.min.");
            }
            this.max = param1.readShort();
            if (this.max < 0)
            {
                throw new Error("Forbidden value (" + this.max + ") on element of SkillActionDescriptionCollect.max.");
            }
            return;
        }// end function

    }
}
