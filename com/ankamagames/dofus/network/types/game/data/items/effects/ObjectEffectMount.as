package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectMount extends ObjectEffect implements INetworkType
    {
        public var mountId:uint = 0;
        public var date:Number = 0;
        public var modelId:uint = 0;
        public static const protocolId:uint = 179;

        public function ObjectEffectMount()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 179;
        }// end function

        public function initObjectEffectMount(param1:uint = 0, param2:uint = 0, param3:Number = 0, param4:uint = 0) : ObjectEffectMount
        {
            super.initObjectEffect(param1);
            this.mountId = param2;
            this.date = param3;
            this.modelId = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.mountId = 0;
            this.date = 0;
            this.modelId = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectMount(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectMount(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffect(param1);
            if (this.mountId < 0)
            {
                throw new Error("Forbidden value (" + this.mountId + ") on element mountId.");
            }
            param1.writeInt(this.mountId);
            param1.writeDouble(this.date);
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            param1.writeShort(this.modelId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectMount(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectMount(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.mountId = param1.readInt();
            if (this.mountId < 0)
            {
                throw new Error("Forbidden value (" + this.mountId + ") on element of ObjectEffectMount.mountId.");
            }
            this.date = param1.readDouble();
            this.modelId = param1.readShort();
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element of ObjectEffectMount.modelId.");
            }
            return;
        }// end function

    }
}
