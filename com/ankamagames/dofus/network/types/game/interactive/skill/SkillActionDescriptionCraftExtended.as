package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SkillActionDescriptionCraftExtended extends SkillActionDescriptionCraft implements INetworkType
    {
        public var thresholdSlots:uint = 0;
        public var optimumProbability:uint = 0;
        public static const protocolId:uint = 104;

        public function SkillActionDescriptionCraftExtended()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 104;
        }// end function

        public function initSkillActionDescriptionCraftExtended(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0) : SkillActionDescriptionCraftExtended
        {
            super.initSkillActionDescriptionCraft(param1, param2, param3);
            this.thresholdSlots = param4;
            this.optimumProbability = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.thresholdSlots = 0;
            this.optimumProbability = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SkillActionDescriptionCraftExtended(param1);
            return;
        }// end function

        public function serializeAs_SkillActionDescriptionCraftExtended(param1:IDataOutput) : void
        {
            super.serializeAs_SkillActionDescriptionCraft(param1);
            if (this.thresholdSlots < 0)
            {
                throw new Error("Forbidden value (" + this.thresholdSlots + ") on element thresholdSlots.");
            }
            param1.writeByte(this.thresholdSlots);
            if (this.optimumProbability < 0)
            {
                throw new Error("Forbidden value (" + this.optimumProbability + ") on element optimumProbability.");
            }
            param1.writeByte(this.optimumProbability);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SkillActionDescriptionCraftExtended(param1);
            return;
        }// end function

        public function deserializeAs_SkillActionDescriptionCraftExtended(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.thresholdSlots = param1.readByte();
            if (this.thresholdSlots < 0)
            {
                throw new Error("Forbidden value (" + this.thresholdSlots + ") on element of SkillActionDescriptionCraftExtended.thresholdSlots.");
            }
            this.optimumProbability = param1.readByte();
            if (this.optimumProbability < 0)
            {
                throw new Error("Forbidden value (" + this.optimumProbability + ") on element of SkillActionDescriptionCraftExtended.optimumProbability.");
            }
            return;
        }// end function

    }
}
