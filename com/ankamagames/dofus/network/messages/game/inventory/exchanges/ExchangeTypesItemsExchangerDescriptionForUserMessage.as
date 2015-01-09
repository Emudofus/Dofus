package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.BidExchangerObjectInfo;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeTypesItemsExchangerDescriptionForUserMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5752;

        private var _isInitialized:Boolean = false;
        public var itemTypeDescriptions:Vector.<BidExchangerObjectInfo>;

        public function ExchangeTypesItemsExchangerDescriptionForUserMessage()
        {
            this.itemTypeDescriptions = new Vector.<BidExchangerObjectInfo>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5752);
        }

        public function initExchangeTypesItemsExchangerDescriptionForUserMessage(itemTypeDescriptions:Vector.<BidExchangerObjectInfo>=null):ExchangeTypesItemsExchangerDescriptionForUserMessage
        {
            this.itemTypeDescriptions = itemTypeDescriptions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.itemTypeDescriptions = new Vector.<BidExchangerObjectInfo>();
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
            this.serializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(output);
        }

        public function serializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.itemTypeDescriptions.length);
            var _i1:uint;
            while (_i1 < this.itemTypeDescriptions.length)
            {
                (this.itemTypeDescriptions[_i1] as BidExchangerObjectInfo).serializeAs_BidExchangerObjectInfo(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(input);
        }

        public function deserializeAs_ExchangeTypesItemsExchangerDescriptionForUserMessage(input:ICustomDataInput):void
        {
            var _item1:BidExchangerObjectInfo;
            var _itemTypeDescriptionsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _itemTypeDescriptionsLen)
            {
                _item1 = new BidExchangerObjectInfo();
                _item1.deserialize(input);
                this.itemTypeDescriptions.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

