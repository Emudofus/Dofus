package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockBuyableInformations extends PaddockInformations implements INetworkType
    {
        public var price:uint = 0;
        public var locked:Boolean = false;
        public static const protocolId:uint = 130;

        public function PaddockBuyableInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 130;
        }// end function

        public function initPaddockBuyableInformations(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:Boolean = false) : PaddockBuyableInformations
        {
            super.initPaddockInformations(param1, param2);
            this.price = param3;
            this.locked = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.price = 0;
            this.locked = false;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PaddockBuyableInformations(param1);
            return;
        }// end function

        public function serializeAs_PaddockBuyableInformations(param1:IDataOutput) : void
        {
            super.serializeAs_PaddockInformations(param1);
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            param1.writeBoolean(this.locked);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockBuyableInformations(param1);
            return;
        }// end function

        public function deserializeAs_PaddockBuyableInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of PaddockBuyableInformations.price.");
            }
            this.locked = param1.readBoolean();
            return;
        }// end function

    }
}
