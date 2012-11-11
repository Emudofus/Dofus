package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectDate extends ObjectEffect implements INetworkType
    {
        public var year:uint = 0;
        public var month:uint = 0;
        public var day:uint = 0;
        public var hour:uint = 0;
        public var minute:uint = 0;
        public static const protocolId:uint = 72;

        public function ObjectEffectDate()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 72;
        }// end function

        public function initObjectEffectDate(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : ObjectEffectDate
        {
            super.initObjectEffect(param1);
            this.year = param2;
            this.month = param3;
            this.day = param4;
            this.hour = param5;
            this.minute = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.year = 0;
            this.month = 0;
            this.day = 0;
            this.hour = 0;
            this.minute = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectDate(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectDate(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffect(param1);
            if (this.year < 0)
            {
                throw new Error("Forbidden value (" + this.year + ") on element year.");
            }
            param1.writeShort(this.year);
            if (this.month < 0)
            {
                throw new Error("Forbidden value (" + this.month + ") on element month.");
            }
            param1.writeShort(this.month);
            if (this.day < 0)
            {
                throw new Error("Forbidden value (" + this.day + ") on element day.");
            }
            param1.writeShort(this.day);
            if (this.hour < 0)
            {
                throw new Error("Forbidden value (" + this.hour + ") on element hour.");
            }
            param1.writeShort(this.hour);
            if (this.minute < 0)
            {
                throw new Error("Forbidden value (" + this.minute + ") on element minute.");
            }
            param1.writeShort(this.minute);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectDate(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectDate(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.year = param1.readShort();
            if (this.year < 0)
            {
                throw new Error("Forbidden value (" + this.year + ") on element of ObjectEffectDate.year.");
            }
            this.month = param1.readShort();
            if (this.month < 0)
            {
                throw new Error("Forbidden value (" + this.month + ") on element of ObjectEffectDate.month.");
            }
            this.day = param1.readShort();
            if (this.day < 0)
            {
                throw new Error("Forbidden value (" + this.day + ") on element of ObjectEffectDate.day.");
            }
            this.hour = param1.readShort();
            if (this.hour < 0)
            {
                throw new Error("Forbidden value (" + this.hour + ") on element of ObjectEffectDate.hour.");
            }
            this.minute = param1.readShort();
            if (this.minute < 0)
            {
                throw new Error("Forbidden value (" + this.minute + ") on element of ObjectEffectDate.minute.");
            }
            return;
        }// end function

    }
}
