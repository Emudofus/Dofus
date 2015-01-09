package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeIsReadyMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5509;

        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var ready:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5509);
        }

        public function initExchangeIsReadyMessage(id:uint=0, ready:Boolean=false):ExchangeIsReadyMessage
        {
            this.id = id;
            this.ready = ready;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = 0;
            this.ready = false;
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
            this.serializeAs_ExchangeIsReadyMessage(output);
        }

        public function serializeAs_ExchangeIsReadyMessage(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarInt(this.id);
            output.writeBoolean(this.ready);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeIsReadyMessage(input);
        }

        public function deserializeAs_ExchangeIsReadyMessage(input:ICustomDataInput):void
        {
            this.id = input.readVarUhInt();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of ExchangeIsReadyMessage.id.")));
            };
            this.ready = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

