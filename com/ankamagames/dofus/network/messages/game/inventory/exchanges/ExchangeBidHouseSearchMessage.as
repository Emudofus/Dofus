package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidHouseSearchMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5806;

        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var genId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5806);
        }

        public function initExchangeBidHouseSearchMessage(type:uint=0, genId:uint=0):ExchangeBidHouseSearchMessage
        {
            this.type = type;
            this.genId = genId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.type = 0;
            this.genId = 0;
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
            this.serializeAs_ExchangeBidHouseSearchMessage(output);
        }

        public function serializeAs_ExchangeBidHouseSearchMessage(output:ICustomDataOutput):void
        {
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element type.")));
            };
            output.writeVarInt(this.type);
            if (this.genId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genId) + ") on element genId.")));
            };
            output.writeVarShort(this.genId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseSearchMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseSearchMessage(input:ICustomDataInput):void
        {
            this.type = input.readVarUhInt();
            if (this.type < 0)
            {
                throw (new Error((("Forbidden value (" + this.type) + ") on element of ExchangeBidHouseSearchMessage.type.")));
            };
            this.genId = input.readVarUhShort();
            if (this.genId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genId) + ") on element of ExchangeBidHouseSearchMessage.genId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

