package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseBuyResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5735;

        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public var bought:Boolean = false;
        public var realPrice:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5735);
        }

        public function initHouseBuyResultMessage(houseId:uint=0, bought:Boolean=false, realPrice:uint=0):HouseBuyResultMessage
        {
            this.houseId = houseId;
            this.bought = bought;
            this.realPrice = realPrice;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houseId = 0;
            this.bought = false;
            this.realPrice = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseBuyResultMessage(output);
        }

        public function serializeAs_HouseBuyResultMessage(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeVarInt(this.houseId);
            output.writeBoolean(this.bought);
            if (this.realPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.realPrice) + ") on element realPrice.")));
            };
            output.writeVarInt(this.realPrice);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseBuyResultMessage(input);
        }

        public function deserializeAs_HouseBuyResultMessage(input:ICustomDataInput):void
        {
            this.houseId = input.readVarUhInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseBuyResultMessage.houseId.")));
            };
            this.bought = input.readBoolean();
            this.realPrice = input.readVarUhInt();
            if (this.realPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.realPrice) + ") on element of HouseBuyResultMessage.realPrice.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

