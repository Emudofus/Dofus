package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInHumanVendorShop;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeStartOkHumanVendorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5767;

        private var _isInitialized:Boolean = false;
        public var sellerId:uint = 0;
        public var objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop>;

        public function ExchangeStartOkHumanVendorMessage()
        {
            this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5767);
        }

        public function initExchangeStartOkHumanVendorMessage(sellerId:uint=0, objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop>=null):ExchangeStartOkHumanVendorMessage
        {
            this.sellerId = sellerId;
            this.objectsInfos = objectsInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.sellerId = 0;
            this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>();
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
            this.serializeAs_ExchangeStartOkHumanVendorMessage(output);
        }

        public function serializeAs_ExchangeStartOkHumanVendorMessage(output:ICustomDataOutput):void
        {
            if (this.sellerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.sellerId) + ") on element sellerId.")));
            };
            output.writeVarInt(this.sellerId);
            output.writeShort(this.objectsInfos.length);
            var _i2:uint;
            while (_i2 < this.objectsInfos.length)
            {
                (this.objectsInfos[_i2] as ObjectItemToSellInHumanVendorShop).serializeAs_ObjectItemToSellInHumanVendorShop(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkHumanVendorMessage(input);
        }

        public function deserializeAs_ExchangeStartOkHumanVendorMessage(input:ICustomDataInput):void
        {
            var _item2:ObjectItemToSellInHumanVendorShop;
            this.sellerId = input.readVarUhInt();
            if (this.sellerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.sellerId) + ") on element of ExchangeStartOkHumanVendorMessage.sellerId.")));
            };
            var _objectsInfosLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _objectsInfosLen)
            {
                _item2 = new ObjectItemToSellInHumanVendorShop();
                _item2.deserialize(input);
                this.objectsInfos.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

