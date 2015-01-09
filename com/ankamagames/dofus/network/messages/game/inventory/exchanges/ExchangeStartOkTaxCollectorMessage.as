package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeStartOkTaxCollectorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5780;

        private var _isInitialized:Boolean = false;
        public var collectorId:int = 0;
        public var objectsInfos:Vector.<ObjectItem>;
        public var goldInfo:uint = 0;

        public function ExchangeStartOkTaxCollectorMessage()
        {
            this.objectsInfos = new Vector.<ObjectItem>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5780);
        }

        public function initExchangeStartOkTaxCollectorMessage(collectorId:int=0, objectsInfos:Vector.<ObjectItem>=null, goldInfo:uint=0):ExchangeStartOkTaxCollectorMessage
        {
            this.collectorId = collectorId;
            this.objectsInfos = objectsInfos;
            this.goldInfo = goldInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.collectorId = 0;
            this.objectsInfos = new Vector.<ObjectItem>();
            this.goldInfo = 0;
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
            this.serializeAs_ExchangeStartOkTaxCollectorMessage(output);
        }

        public function serializeAs_ExchangeStartOkTaxCollectorMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.collectorId);
            output.writeShort(this.objectsInfos.length);
            var _i2:uint;
            while (_i2 < this.objectsInfos.length)
            {
                (this.objectsInfos[_i2] as ObjectItem).serializeAs_ObjectItem(output);
                _i2++;
            };
            if (this.goldInfo < 0)
            {
                throw (new Error((("Forbidden value (" + this.goldInfo) + ") on element goldInfo.")));
            };
            output.writeVarInt(this.goldInfo);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkTaxCollectorMessage(input);
        }

        public function deserializeAs_ExchangeStartOkTaxCollectorMessage(input:ICustomDataInput):void
        {
            var _item2:ObjectItem;
            this.collectorId = input.readInt();
            var _objectsInfosLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _objectsInfosLen)
            {
                _item2 = new ObjectItem();
                _item2.deserialize(input);
                this.objectsInfos.push(_item2);
                _i2++;
            };
            this.goldInfo = input.readVarUhInt();
            if (this.goldInfo < 0)
            {
                throw (new Error((("Forbidden value (" + this.goldInfo) + ") on element of ExchangeStartOkTaxCollectorMessage.goldInfo.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

