package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeObjectsModifiedMessage extends ExchangeObjectMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6533;

        private var _isInitialized:Boolean = false;
        public var object:Vector.<ObjectItem>;

        public function ExchangeObjectsModifiedMessage()
        {
            this.object = new Vector.<ObjectItem>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6533);
        }

        public function initExchangeObjectsModifiedMessage(remote:Boolean=false, object:Vector.<ObjectItem>=null):ExchangeObjectsModifiedMessage
        {
            super.initExchangeObjectMessage(remote);
            this.object = object;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.object = new Vector.<ObjectItem>();
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

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ExchangeObjectsModifiedMessage(output);
        }

        public function serializeAs_ExchangeObjectsModifiedMessage(output:IDataOutput):void
        {
            super.serializeAs_ExchangeObjectMessage(output);
            output.writeShort(this.object.length);
            var _i1:uint;
            while (_i1 < this.object.length)
            {
                (this.object[_i1] as ObjectItem).serializeAs_ObjectItem(output);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeObjectsModifiedMessage(input);
        }

        public function deserializeAs_ExchangeObjectsModifiedMessage(input:IDataInput):void
        {
            var _item1:ObjectItem;
            super.deserialize(input);
            var _objectLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _objectLen)
            {
                _item1 = new ObjectItem();
                _item1.deserialize(input);
                this.object.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

