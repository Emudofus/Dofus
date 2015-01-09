package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectEffectDuration extends ObjectEffect implements INetworkType 
    {

        public static const protocolId:uint = 75;

        public var days:uint = 0;
        public var hours:uint = 0;
        public var minutes:uint = 0;


        override public function getTypeId():uint
        {
            return (75);
        }

        public function initObjectEffectDuration(actionId:uint=0, days:uint=0, hours:uint=0, minutes:uint=0):ObjectEffectDuration
        {
            super.initObjectEffect(actionId);
            this.days = days;
            this.hours = hours;
            this.minutes = minutes;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.days = 0;
            this.hours = 0;
            this.minutes = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectEffectDuration(output);
        }

        public function serializeAs_ObjectEffectDuration(output:ICustomDataOutput):void
        {
            super.serializeAs_ObjectEffect(output);
            if (this.days < 0)
            {
                throw (new Error((("Forbidden value (" + this.days) + ") on element days.")));
            };
            output.writeVarShort(this.days);
            if (this.hours < 0)
            {
                throw (new Error((("Forbidden value (" + this.hours) + ") on element hours.")));
            };
            output.writeByte(this.hours);
            if (this.minutes < 0)
            {
                throw (new Error((("Forbidden value (" + this.minutes) + ") on element minutes.")));
            };
            output.writeByte(this.minutes);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectEffectDuration(input);
        }

        public function deserializeAs_ObjectEffectDuration(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.days = input.readVarUhShort();
            if (this.days < 0)
            {
                throw (new Error((("Forbidden value (" + this.days) + ") on element of ObjectEffectDuration.days.")));
            };
            this.hours = input.readByte();
            if (this.hours < 0)
            {
                throw (new Error((("Forbidden value (" + this.hours) + ") on element of ObjectEffectDuration.hours.")));
            };
            this.minutes = input.readByte();
            if (this.minutes < 0)
            {
                throw (new Error((("Forbidden value (" + this.minutes) + ") on element of ObjectEffectDuration.minutes.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items.effects

