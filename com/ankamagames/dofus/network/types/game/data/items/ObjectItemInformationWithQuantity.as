package com.ankamagames.dofus.network.types.game.data.items
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectItemInformationWithQuantity extends ObjectItemMinimalInformation implements INetworkType
    {
        public var quantity:uint = 0;
        public static const protocolId:uint = 387;

        public function ObjectItemInformationWithQuantity()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 387;
        }// end function

        public function initObjectItemInformationWithQuantity(param1:uint = 0, param2:int = 0, param3:Boolean = false, param4:Vector.<ObjectEffect> = null, param5:uint = 0) : ObjectItemInformationWithQuantity
        {
            super.initObjectItemMinimalInformation(param1, param2, param3, param4);
            this.quantity = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.quantity = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectItemInformationWithQuantity(param1);
            return;
        }// end function

        public function serializeAs_ObjectItemInformationWithQuantity(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectItemMinimalInformation(param1);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectItemInformationWithQuantity(param1);
            return;
        }// end function

        public function deserializeAs_ObjectItemInformationWithQuantity(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemInformationWithQuantity.quantity.");
            }
            return;
        }// end function

    }
}
