package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSell;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeShopStockStartedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5910;

        private var _isInitialized:Boolean = false;
        public var objectsInfos:Vector.<ObjectItemToSell>;

        public function ExchangeShopStockStartedMessage()
        {
            this.objectsInfos = new Vector.<ObjectItemToSell>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5910);
        }

        public function initExchangeShopStockStartedMessage(objectsInfos:Vector.<ObjectItemToSell>=null):ExchangeShopStockStartedMessage
        {
            this.objectsInfos = objectsInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectsInfos = new Vector.<ObjectItemToSell>();
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
            this.serializeAs_ExchangeShopStockStartedMessage(output);
        }

        public function serializeAs_ExchangeShopStockStartedMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.objectsInfos.length);
            var _i1:uint;
            while (_i1 < this.objectsInfos.length)
            {
                (this.objectsInfos[_i1] as ObjectItemToSell).serializeAs_ObjectItemToSell(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeShopStockStartedMessage(input);
        }

        public function deserializeAs_ExchangeShopStockStartedMessage(input:ICustomDataInput):void
        {
            var _item1:ObjectItemToSell;
            var _objectsInfosLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectsInfosLen)
            {
                _item1 = new ObjectItemToSell();
                _item1.deserialize(input);
                this.objectsInfos.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

