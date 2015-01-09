package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectEffectInteger extends ObjectEffect implements INetworkType 
    {

        public static const protocolId:uint = 70;

        public var value:uint = 0;


        override public function getTypeId():uint
        {
            return (70);
        }

        public function initObjectEffectInteger(actionId:uint=0, value:uint=0):ObjectEffectInteger
        {
            super.initObjectEffect(actionId);
            this.value = value;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.value = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectEffectInteger(output);
        }

        public function serializeAs_ObjectEffectInteger(output:ICustomDataOutput):void
        {
            super.serializeAs_ObjectEffect(output);
            if (this.value < 0)
            {
                throw (new Error((("Forbidden value (" + this.value) + ") on element value.")));
            };
            output.writeVarShort(this.value);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectEffectInteger(input);
        }

        public function deserializeAs_ObjectEffectInteger(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.value = input.readVarUhShort();
            if (this.value < 0)
            {
                throw (new Error((("Forbidden value (" + this.value) + ") on element of ObjectEffectInteger.value.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items.effects

