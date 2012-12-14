package com.ankamagames.dofus.network.types.game.interactive
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveElementWithAgeBonus extends InteractiveElement implements INetworkType
    {
        public var ageBonus:int = 0;
        public static const protocolId:uint = 398;

        public function InteractiveElementWithAgeBonus()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 398;
        }// end function

        public function initInteractiveElementWithAgeBonus(param1:uint = 0, param2:int = 0, param3:Vector.<InteractiveElementSkill> = null, param4:Vector.<InteractiveElementSkill> = null, param5:int = 0) : InteractiveElementWithAgeBonus
        {
            super.initInteractiveElement(param1, param2, param3, param4);
            this.ageBonus = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.ageBonus = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_InteractiveElementWithAgeBonus(param1);
            return;
        }// end function

        public function serializeAs_InteractiveElementWithAgeBonus(param1:IDataOutput) : void
        {
            super.serializeAs_InteractiveElement(param1);
            if (this.ageBonus < -1 || this.ageBonus > 1000)
            {
                throw new Error("Forbidden value (" + this.ageBonus + ") on element ageBonus.");
            }
            param1.writeShort(this.ageBonus);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveElementWithAgeBonus(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveElementWithAgeBonus(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.ageBonus = param1.readShort();
            if (this.ageBonus < -1 || this.ageBonus > 1000)
            {
                throw new Error("Forbidden value (" + this.ageBonus + ") on element of InteractiveElementWithAgeBonus.ageBonus.");
            }
            return;
        }// end function

    }
}
