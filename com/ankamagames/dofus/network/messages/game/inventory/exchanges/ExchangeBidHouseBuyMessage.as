package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeBidHouseBuyMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5804;

        private var _isInitialized:Boolean = false;
        public var uid:uint = 0;
        public var qty:uint = 0;
        public var price:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5804);
        }

        public function initExchangeBidHouseBuyMessage(uid:uint=0, qty:uint=0, price:uint=0):ExchangeBidHouseBuyMessage
        {
            this.uid = uid;
            this.qty = qty;
            this.price = price;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.uid = 0;
            this.qty = 0;
            this.price = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ExchangeBidHouseBuyMessage(output);
        }

        public function serializeAs_ExchangeBidHouseBuyMessage(output:IDataOutput):void
        {
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element uid.")));
            };
            output.writeInt(this.uid);
            if (this.qty < 0)
            {
                throw (new Error((("Forbidden value (" + this.qty) + ") on element qty.")));
            };
            output.writeInt(this.qty);
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element price.")));
            };
            output.writeInt(this.price);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseBuyMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseBuyMessage(input:IDataInput):void
        {
            this.uid = input.readInt();
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element of ExchangeBidHouseBuyMessage.uid.")));
            };
            this.qty = input.readInt();
            if (this.qty < 0)
            {
                throw (new Error((("Forbidden value (" + this.qty) + ") on element of ExchangeBidHouseBuyMessage.qty.")));
            };
            this.price = input.readInt();
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element of ExchangeBidHouseBuyMessage.price.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

