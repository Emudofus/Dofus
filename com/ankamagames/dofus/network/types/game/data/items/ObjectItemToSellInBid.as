package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class ObjectItemToSellInBid extends ObjectItemToSell implements INetworkType 
    {

        public static const protocolId:uint = 164;

        public var unsoldDelay:uint = 0;


        override public function getTypeId():uint
        {
            return (164);
        }

        public function initObjectItemToSellInBid(objectGID:uint=0, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0, objectPrice:uint=0, unsoldDelay:uint=0):ObjectItemToSellInBid
        {
            super.initObjectItemToSell(objectGID, effects, objectUID, quantity, objectPrice);
            this.unsoldDelay = unsoldDelay;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.unsoldDelay = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectItemToSellInBid(output);
        }

        public function serializeAs_ObjectItemToSellInBid(output:ICustomDataOutput):void
        {
            super.serializeAs_ObjectItemToSell(output);
            if (this.unsoldDelay < 0)
            {
                throw (new Error((("Forbidden value (" + this.unsoldDelay) + ") on element unsoldDelay.")));
            };
            output.writeInt(this.unsoldDelay);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectItemToSellInBid(input);
        }

        public function deserializeAs_ObjectItemToSellInBid(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.unsoldDelay = input.readInt();
            if (this.unsoldDelay < 0)
            {
                throw (new Error((("Forbidden value (" + this.unsoldDelay) + ") on element of ObjectItemToSellInBid.unsoldDelay.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items

