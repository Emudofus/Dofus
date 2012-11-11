package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class Item extends Object implements INetworkType
    {
        public static const protocolId:uint = 7;

        public function Item()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 7;
        }// end function

        public function initItem() : Item
        {
            return this;
        }// end function

        public function reset() : void
        {
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            return;
        }// end function

        public function serializeAs_Item(param1:IDataOutput) : void
        {
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            return;
        }// end function

        public function deserializeAs_Item(param1:IDataInput) : void
        {
            return;
        }// end function

    }
}
