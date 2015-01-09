package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeStartOkCraftWithInformationMessage extends ExchangeStartOkCraftMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5941;

        private var _isInitialized:Boolean = false;
        public var nbCase:uint = 0;
        public var skillId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5941);
        }

        public function initExchangeStartOkCraftWithInformationMessage(nbCase:uint=0, skillId:uint=0):ExchangeStartOkCraftWithInformationMessage
        {
            this.nbCase = nbCase;
            this.skillId = skillId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.nbCase = 0;
            this.skillId = 0;
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
            this.serializeAs_ExchangeStartOkCraftWithInformationMessage(output);
        }

        public function serializeAs_ExchangeStartOkCraftWithInformationMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeStartOkCraftMessage(output);
            if (this.nbCase < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbCase) + ") on element nbCase.")));
            };
            output.writeByte(this.nbCase);
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element skillId.")));
            };
            output.writeVarInt(this.skillId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkCraftWithInformationMessage(input);
        }

        public function deserializeAs_ExchangeStartOkCraftWithInformationMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.nbCase = input.readByte();
            if (this.nbCase < 0)
            {
                throw (new Error((("Forbidden value (" + this.nbCase) + ") on element of ExchangeStartOkCraftWithInformationMessage.nbCase.")));
            };
            this.skillId = input.readVarUhInt();
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element of ExchangeStartOkCraftWithInformationMessage.skillId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

