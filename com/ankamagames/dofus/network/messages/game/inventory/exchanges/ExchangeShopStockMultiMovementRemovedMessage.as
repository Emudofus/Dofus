﻿package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeShopStockMultiMovementRemovedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6037;

        private var _isInitialized:Boolean = false;
        public var objectIdList:Vector.<uint>;

        public function ExchangeShopStockMultiMovementRemovedMessage()
        {
            this.objectIdList = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6037);
        }

        public function initExchangeShopStockMultiMovementRemovedMessage(objectIdList:Vector.<uint>=null):ExchangeShopStockMultiMovementRemovedMessage
        {
            this.objectIdList = objectIdList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectIdList = new Vector.<uint>();
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
            this.serializeAs_ExchangeShopStockMultiMovementRemovedMessage(output);
        }

        public function serializeAs_ExchangeShopStockMultiMovementRemovedMessage(output:IDataOutput):void
        {
            output.writeShort(this.objectIdList.length);
            var _i1:uint;
            while (_i1 < this.objectIdList.length)
            {
                if (this.objectIdList[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.objectIdList[_i1]) + ") on element 1 (starting at 1) of objectIdList.")));
                };
                output.writeInt(this.objectIdList[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(input);
        }

        public function deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _objectIdListLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectIdListLen)
            {
                _val1 = input.readInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of objectIdList.")));
                };
                this.objectIdList.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges
