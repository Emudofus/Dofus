package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ObjectFoundWhileRecoltingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6017;

        private var _isInitialized:Boolean = false;
        public var genericId:uint = 0;
        public var quantity:uint = 0;
        public var resourceGenericId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6017);
        }

        public function initObjectFoundWhileRecoltingMessage(genericId:uint=0, quantity:uint=0, resourceGenericId:uint=0):ObjectFoundWhileRecoltingMessage
        {
            this.genericId = genericId;
            this.quantity = quantity;
            this.resourceGenericId = resourceGenericId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.genericId = 0;
            this.quantity = 0;
            this.resourceGenericId = 0;
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
            this.serializeAs_ObjectFoundWhileRecoltingMessage(output);
        }

        public function serializeAs_ObjectFoundWhileRecoltingMessage(output:ICustomDataOutput):void
        {
            if (this.genericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genericId) + ") on element genericId.")));
            };
            output.writeVarShort(this.genericId);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeVarInt(this.quantity);
            if (this.resourceGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.resourceGenericId) + ") on element resourceGenericId.")));
            };
            output.writeVarInt(this.resourceGenericId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectFoundWhileRecoltingMessage(input);
        }

        public function deserializeAs_ObjectFoundWhileRecoltingMessage(input:ICustomDataInput):void
        {
            this.genericId = input.readVarUhShort();
            if (this.genericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.genericId) + ") on element of ObjectFoundWhileRecoltingMessage.genericId.")));
            };
            this.quantity = input.readVarUhInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ObjectFoundWhileRecoltingMessage.quantity.")));
            };
            this.resourceGenericId = input.readVarUhInt();
            if (this.resourceGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.resourceGenericId) + ") on element of ObjectFoundWhileRecoltingMessage.resourceGenericId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

