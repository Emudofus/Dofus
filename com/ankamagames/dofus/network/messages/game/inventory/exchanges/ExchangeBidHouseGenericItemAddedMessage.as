package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidHouseGenericItemAddedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5947;

        private var _isInitialized:Boolean = false;
        public var objGenericId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5947);
        }

        public function initExchangeBidHouseGenericItemAddedMessage(objGenericId:uint=0):ExchangeBidHouseGenericItemAddedMessage
        {
            this.objGenericId = objGenericId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objGenericId = 0;
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
            this.serializeAs_ExchangeBidHouseGenericItemAddedMessage(output);
        }

        public function serializeAs_ExchangeBidHouseGenericItemAddedMessage(output:ICustomDataOutput):void
        {
            if (this.objGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objGenericId) + ") on element objGenericId.")));
            };
            output.writeVarShort(this.objGenericId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseGenericItemAddedMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseGenericItemAddedMessage(input:ICustomDataInput):void
        {
            this.objGenericId = input.readVarUhShort();
            if (this.objGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objGenericId) + ") on element of ExchangeBidHouseGenericItemAddedMessage.objGenericId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

