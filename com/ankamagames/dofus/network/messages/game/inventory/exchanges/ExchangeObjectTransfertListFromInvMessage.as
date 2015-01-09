package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeObjectTransfertListFromInvMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6183;

        private var _isInitialized:Boolean = false;
        public var ids:Vector.<uint>;

        public function ExchangeObjectTransfertListFromInvMessage()
        {
            this.ids = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6183);
        }

        public function initExchangeObjectTransfertListFromInvMessage(ids:Vector.<uint>=null):ExchangeObjectTransfertListFromInvMessage
        {
            this.ids = ids;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ids = new Vector.<uint>();
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
            this.serializeAs_ExchangeObjectTransfertListFromInvMessage(output);
        }

        public function serializeAs_ExchangeObjectTransfertListFromInvMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.ids.length);
            var _i1:uint;
            while (_i1 < this.ids.length)
            {
                if (this.ids[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.ids[_i1]) + ") on element 1 (starting at 1) of ids.")));
                };
                output.writeVarInt(this.ids[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeObjectTransfertListFromInvMessage(input);
        }

        public function deserializeAs_ExchangeObjectTransfertListFromInvMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _idsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _idsLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of ids.")));
                };
                this.ids.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

