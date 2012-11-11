package com.ankamagames.dofus.network.types.game.interactive.skill
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SkillActionDescription extends Object implements INetworkType
    {
        public var skillId:uint = 0;
        public static const protocolId:uint = 102;

        public function SkillActionDescription()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 102;
        }// end function

        public function initSkillActionDescription(param1:uint = 0) : SkillActionDescription
        {
            this.skillId = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.skillId = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SkillActionDescription(param1);
            return;
        }// end function

        public function serializeAs_SkillActionDescription(param1:IDataOutput) : void
        {
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            param1.writeShort(this.skillId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SkillActionDescription(param1);
            return;
        }// end function

        public function deserializeAs_SkillActionDescription(param1:IDataInput) : void
        {
            this.skillId = param1.readShort();
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element of SkillActionDescription.skillId.");
            }
            return;
        }// end function

    }
}
