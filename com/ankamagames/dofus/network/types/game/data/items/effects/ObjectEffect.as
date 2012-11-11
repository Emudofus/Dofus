package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffect extends Object implements INetworkType
    {
        public var actionId:uint = 0;
        public static const protocolId:uint = 76;

        public function ObjectEffect()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 76;
        }// end function

        public function initObjectEffect(param1:uint = 0) : ObjectEffect
        {
            this.actionId = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.actionId = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffect(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffect(param1:IDataOutput) : void
        {
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
            }
            param1.writeShort(this.actionId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffect(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffect(param1:IDataInput) : void
        {
            this.actionId = param1.readShort();
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element of ObjectEffect.actionId.");
            }
            return;
        }// end function

    }
}
