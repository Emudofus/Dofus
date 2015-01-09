package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ObjectDeleteMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 3022;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var quantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (3022);
        }

        public function initObjectDeleteMessage(objectUID:uint=0, quantity:uint=0):ObjectDeleteMessage
        {
            this.objectUID = objectUID;
            this.quantity = quantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectUID = 0;
            this.quantity = 0;
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

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ObjectDeleteMessage(output);
        }

        public function serializeAs_ObjectDeleteMessage(output:IDataOutput):void
        {
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeInt(this.objectUID);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeInt(this.quantity);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ObjectDeleteMessage(input);
        }

        public function deserializeAs_ObjectDeleteMessage(input:IDataInput):void
        {
            this.objectUID = input.readInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ObjectDeleteMessage.objectUID.")));
            };
            this.quantity = input.readInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ObjectDeleteMessage.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

