package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeObjectRemovedFromBagMessage extends ExchangeObjectMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6010;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6010);
        }

        public function initExchangeObjectRemovedFromBagMessage(remote:Boolean=false, objectUID:uint=0):ExchangeObjectRemovedFromBagMessage
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
            this.serializeAs_ExchangeObjectRemovedFromBagMessage(output);
        }

        public function serializeAs_ExchangeObjectRemovedFromBagMessage(output:IDataOutput):void
        {
            super.serializeAs_ExchangeObjectMessage(output);
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeInt(this.objectUID);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeObjectRemovedFromBagMessage(input);
        }

        public function deserializeAs_ExchangeObjectRemovedFromBagMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.objectUID = input.readInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ExchangeObjectRemovedFromBagMessage.objectUID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

