package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ObjectFeedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6290;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var foodUID:uint = 0;
        public var foodQuantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6290);
        }

        public function initObjectFeedMessage(objectUID:uint=0, foodUID:uint=0, foodQuantity:uint=0):ObjectFeedMessage
        {
            this.objectUID = objectUID;
            this.foodUID = foodUID;
            this.foodQuantity = foodQuantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.objectUID = 0;
            this.foodUID = 0;
            this.foodQuantity = 0;
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
            this.serializeAs_ObjectFeedMessage(output);
        }

        public function serializeAs_ObjectFeedMessage(output:IDataOutput):void
        {
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeInt(this.objectUID);
            if (this.foodUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.foodUID) + ") on element foodUID.")));
            };
            output.writeInt(this.foodUID);
            if (this.foodQuantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.foodQuantity) + ") on element foodQuantity.")));
            };
            output.writeShort(this.foodQuantity);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ObjectFeedMessage(input);
        }

        public function deserializeAs_ObjectFeedMessage(input:IDataInput):void
        {
            this.objectUID = input.readInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ObjectFeedMessage.objectUID.")));
            };
            this.foodUID = input.readInt();
            if (this.foodUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.foodUID) + ") on element of ObjectFeedMessage.foodUID.")));
            };
            this.foodQuantity = input.readShort();
            if (this.foodQuantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.foodQuantity) + ") on element of ObjectFeedMessage.foodQuantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

