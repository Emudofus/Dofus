package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectDuration extends ObjectEffect implements INetworkType
    {
        public var days:uint = 0;
        public var hours:uint = 0;
        public var minutes:uint = 0;
        public static const protocolId:uint = 75;

        public function ObjectEffectDuration()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 75;
        }// end function

        public function initObjectEffectDuration(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : ObjectEffectDuration
        {
            super.initObjectEffect(param1);
            this.days = param2;
            this.hours = param3;
            this.minutes = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.days = 0;
            this.hours = 0;
            this.minutes = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectDuration(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectDuration(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffect(param1);
            if (this.days < 0)
            {
                throw new Error("Forbidden value (" + this.days + ") on element days.");
            }
            param1.writeShort(this.days);
            if (this.hours < 0)
            {
                throw new Error("Forbidden value (" + this.hours + ") on element hours.");
            }
            param1.writeShort(this.hours);
            if (this.minutes < 0)
            {
                throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
            }
            param1.writeShort(this.minutes);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectDuration(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectDuration(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.days = param1.readShort();
            if (this.days < 0)
            {
                throw new Error("Forbidden value (" + this.days + ") on element of ObjectEffectDuration.days.");
            }
            this.hours = param1.readShort();
            if (this.hours < 0)
            {
                throw new Error("Forbidden value (" + this.hours + ") on element of ObjectEffectDuration.hours.");
            }
            this.minutes = param1.readShort();
            if (this.minutes < 0)
            {
                throw new Error("Forbidden value (" + this.minutes + ") on element of ObjectEffectDuration.minutes.");
            }
            return;
        }// end function

    }
}
