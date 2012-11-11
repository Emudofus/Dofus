package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectInteger extends ObjectEffect implements INetworkType
    {
        public var value:uint = 0;
        public static const protocolId:uint = 70;

        public function ObjectEffectInteger()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 70;
        }// end function

        public function initObjectEffectInteger(param1:uint = 0, param2:uint = 0) : ObjectEffectInteger
        {
            super.initObjectEffect(param1);
            this.value = param2;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.value = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectInteger(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectInteger(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffect(param1);
            if (this.value < 0)
            {
                throw new Error("Forbidden value (" + this.value + ") on element value.");
            }
            param1.writeShort(this.value);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectInteger(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectInteger(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.value = param1.readShort();
            if (this.value < 0)
            {
                throw new Error("Forbidden value (" + this.value + ") on element of ObjectEffectInteger.value.");
            }
            return;
        }// end function

    }
}
