package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SkillActionDescriptionCraft extends SkillActionDescription implements INetworkType
    {
        public var maxSlots:uint = 0;
        public var probability:uint = 0;
        public static const protocolId:uint = 100;

        public function SkillActionDescriptionCraft()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 100;
        }// end function

        public function initSkillActionDescriptionCraft(param1:uint = 0, param2:uint = 0, param3:uint = 0) : SkillActionDescriptionCraft
        {
            super.initSkillActionDescription(param1);
            this.maxSlots = param2;
            this.probability = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.maxSlots = 0;
            this.probability = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SkillActionDescriptionCraft(param1);
            return;
        }// end function

        public function serializeAs_SkillActionDescriptionCraft(param1:IDataOutput) : void
        {
            super.serializeAs_SkillActionDescription(param1);
            if (this.maxSlots < 0)
            {
                throw new Error("Forbidden value (" + this.maxSlots + ") on element maxSlots.");
            }
            param1.writeByte(this.maxSlots);
            if (this.probability < 0)
            {
                throw new Error("Forbidden value (" + this.probability + ") on element probability.");
            }
            param1.writeByte(this.probability);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SkillActionDescriptionCraft(param1);
            return;
        }// end function

        public function deserializeAs_SkillActionDescriptionCraft(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.maxSlots = param1.readByte();
            if (this.maxSlots < 0)
            {
                throw new Error("Forbidden value (" + this.maxSlots + ") on element of SkillActionDescriptionCraft.maxSlots.");
            }
            this.probability = param1.readByte();
            if (this.probability < 0)
            {
                throw new Error("Forbidden value (" + this.probability + ") on element of SkillActionDescriptionCraft.probability.");
            }
            return;
        }// end function

    }
}
