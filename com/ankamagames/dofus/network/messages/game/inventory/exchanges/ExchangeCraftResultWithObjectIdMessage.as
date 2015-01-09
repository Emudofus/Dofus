package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeCraftResultWithObjectIdMessage extends ExchangeCraftResultMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6000;

        private var _isInitialized:Boolean = false;
        public var objectGenericId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6000);
        }

        public function initExchangeCraftResultWithObjectIdMessage(craftResult:uint=0, objectGenericId:uint=0):ExchangeCraftResultWithObjectIdMessage
        {
            super.initExchangeCraftResultMessage(craftResult);
            this.objectGenericId = objectGenericId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.objectGenericId = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExchangeCraftResultWithObjectIdMessage(output);
        }

        public function serializeAs_ExchangeCraftResultWithObjectIdMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeCraftResultMessage(output);
            if (this.objectGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGenericId) + ") on element objectGenericId.")));
            };
            output.writeVarShort(this.objectGenericId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeCraftResultWithObjectIdMessage(input);
        }

        public function deserializeAs_ExchangeCraftResultWithObjectIdMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.objectGenericId = input.readVarUhShort();
            if (this.objectGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGenericId) + ") on element of ExchangeCraftResultWithObjectIdMessage.objectGenericId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

