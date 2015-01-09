package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class WrapperObjectDissociateRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6524;

        private var _isInitialized:Boolean = false;
        public var hostUID:uint = 0;
        public var hostPos:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6524);
        }

        public function initWrapperObjectDissociateRequestMessage(hostUID:uint=0, hostPos:uint=0):WrapperObjectDissociateRequestMessage
        {
            this.hostUID = hostUID;
            this.hostPos = hostPos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.hostUID = 0;
            this.hostPos = 0;
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
            this.serializeAs_WrapperObjectDissociateRequestMessage(output);
        }

        public function serializeAs_WrapperObjectDissociateRequestMessage(output:IDataOutput):void
        {
            if (this.hostUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostUID) + ") on element hostUID.")));
            };
            output.writeInt(this.hostUID);
            if ((((this.hostPos < 0)) || ((this.hostPos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.hostPos) + ") on element hostPos.")));
            };
            output.writeByte(this.hostPos);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_WrapperObjectDissociateRequestMessage(input);
        }

        public function deserializeAs_WrapperObjectDissociateRequestMessage(input:IDataInput):void
        {
            this.hostUID = input.readInt();
            if (this.hostUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostUID) + ") on element of WrapperObjectDissociateRequestMessage.hostUID.")));
            };
            this.hostPos = input.readUnsignedByte();
            if ((((this.hostPos < 0)) || ((this.hostPos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.hostPos) + ") on element of WrapperObjectDissociateRequestMessage.hostPos.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

