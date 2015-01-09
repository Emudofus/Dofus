package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ObjectUseMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 3019;

        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (3019);
        }

        public function initObjectUseMessage(objectUID:uint=0):ObjectUseMessage
        {
            this.objectUID = objectUID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ObjectUseMessage(output);
        }

        public function serializeAs_ObjectUseMessage(output:IDataOutput):void
        {
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeInt(this.objectUID);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ObjectUseMessage(input);
        }

        public function deserializeAs_ObjectUseMessage(input:IDataInput):void
        {
            this.objectUID = input.readInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ObjectUseMessage.objectUID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

