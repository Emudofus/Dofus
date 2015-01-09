package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeObjectRemovedMessage extends ExchangeObjectMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5517;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5517);
        }

        public function initExchangeObjectRemovedMessage(remote:Boolean=false, objectUID:uint=0):ExchangeObjectRemovedMessage
        {
            super.initExchangeObjectMessage(remote);
            this.objectUID = objectUID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.objectUID = 0;
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
            this.serializeAs_ExchangeObjectRemovedMessage(output);
        }

        public function serializeAs_ExchangeObjectRemovedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeObjectMessage(output);
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeVarInt(this.objectUID);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeObjectRemovedMessage(input);
        }

        public function deserializeAs_ExchangeObjectRemovedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.objectUID = input.readVarUhInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ExchangeObjectRemovedMessage.objectUID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

