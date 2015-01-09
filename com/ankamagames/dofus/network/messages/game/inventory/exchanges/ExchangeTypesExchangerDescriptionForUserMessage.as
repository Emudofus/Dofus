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
    public class ExchangeTypesExchangerDescriptionForUserMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5765;

        private var _isInitialized:Boolean = false;
        public var typeDescription:Vector.<uint>;

        public function ExchangeTypesExchangerDescriptionForUserMessage()
        {
            this.typeDescription = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5765);
        }

        public function initExchangeTypesExchangerDescriptionForUserMessage(typeDescription:Vector.<uint>=null):ExchangeTypesExchangerDescriptionForUserMessage
        {
            this.typeDescription = typeDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.typeDescription = new Vector.<uint>();
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
            this.serializeAs_ExchangeTypesExchangerDescriptionForUserMessage(output);
        }

        public function serializeAs_ExchangeTypesExchangerDescriptionForUserMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.typeDescription.length);
            var _i1:uint;
            while (_i1 < this.typeDescription.length)
            {
                if (this.typeDescription[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.typeDescription[_i1]) + ") on element 1 (starting at 1) of typeDescription.")));
                };
                output.writeVarInt(this.typeDescription[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeTypesExchangerDescriptionForUserMessage(input);
        }

        public function deserializeAs_ExchangeTypesExchangerDescriptionForUserMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _typeDescriptionLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _typeDescriptionLen)
            {
                _val1 = input.readVarUhInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of typeDescription.")));
                };
                this.typeDescription.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

