package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveElementNamedSkill extends InteractiveElementSkill implements INetworkType
    {
        public var nameId:uint = 0;
        public static const protocolId:uint = 220;

        public function InteractiveElementNamedSkill()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 220;
        }// end function

        public function initInteractiveElementNamedSkill(param1:uint = 0, param2:uint = 0, param3:uint = 0) : InteractiveElementNamedSkill
        {
            super.initInteractiveElementSkill(param1, param2);
            this.nameId = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.nameId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_InteractiveElementNamedSkill(param1);
            return;
        }// end function

        public function serializeAs_InteractiveElementNamedSkill(param1:IDataOutput) : void
        {
            super.serializeAs_InteractiveElementSkill(param1);
            if (this.nameId < 0)
            {
                throw new Error("Forbidden value (" + this.nameId + ") on element nameId.");
            }
            param1.writeInt(this.nameId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveElementNamedSkill(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveElementNamedSkill(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.nameId = param1.readInt();
            if (this.nameId < 0)
            {
                throw new Error("Forbidden value (" + this.nameId + ") on element of InteractiveElementNamedSkill.nameId.");
            }
            return;
        }// end function

    }
}
