package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class Item implements INetworkType 
    {

        public static const protocolId:uint = 7;


        public function getTypeId():uint
        {
            return (7);
        }

        public function initItem():Item
        {
            return (this);
        }

        public function reset():void
        {
        }

        public function serialize(output:ICustomDataOutput):void
        {
        }

        public function serializeAs_Item(output:ICustomDataOutput):void
        {
        }

        public function deserialize(input:ICustomDataInput):void
        {
        }

        public function deserializeAs_Item(input:ICustomDataInput):void
        {
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items

