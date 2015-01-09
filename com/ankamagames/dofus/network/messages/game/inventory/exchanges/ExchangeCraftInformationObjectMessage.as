package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeCraftInformationObjectMessage extends ExchangeCraftResultWithObjectIdMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5794;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5794);
        }

        public function initExchangeCraftInformationObjectMessage(craftResult:uint=0, objectGenericId:uint=0, playerId:uint=0):ExchangeCraftInformationObjectMessage
        {
            super.initExchangeCraftResultWithObjectIdMessage(craftResult, objectGenericId);
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerId = 0;
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
            this.serializeAs_ExchangeCraftInformationObjectMessage(output);
        }

        public function serializeAs_ExchangeCraftInformationObjectMessage(output:IDataOutput):void
        {
            super.serializeAs_ExchangeCraftResultWithObjectIdMessage(output);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeInt(this.playerId);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeCraftInformationObjectMessage(input);
        }

        public function deserializeAs_ExchangeCraftInformationObjectMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.playerId = input.readInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of ExchangeCraftInformationObjectMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

