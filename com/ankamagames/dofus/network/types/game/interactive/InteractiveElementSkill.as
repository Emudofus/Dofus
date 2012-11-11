package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveElementSkill extends Object implements INetworkType
    {
        public var skillId:uint = 0;
        public var skillInstanceUid:uint = 0;
        public static const protocolId:uint = 219;

        public function InteractiveElementSkill()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 219;
        }// end function

        public function initInteractiveElementSkill(param1:uint = 0, param2:uint = 0) : InteractiveElementSkill
        {
            this.skillId = param1;
            this.skillInstanceUid = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.skillId = 0;
            this.skillInstanceUid = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_InteractiveElementSkill(param1);
            return;
        }// end function

        public function serializeAs_InteractiveElementSkill(param1:IDataOutput) : void
        {
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            param1.writeInt(this.skillId);
            if (this.skillInstanceUid < 0)
            {
                throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
            }
            param1.writeInt(this.skillInstanceUid);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveElementSkill(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveElementSkill(param1:IDataInput) : void
        {
            this.skillId = param1.readInt();
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveElementSkill.skillId.");
            }
            this.skillInstanceUid = param1.readInt();
            if (this.skillInstanceUid < 0)
            {
                throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveElementSkill.skillInstanceUid.");
            }
            return;
        }// end function

    }
}
