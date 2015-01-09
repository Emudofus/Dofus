package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class IdentificationFailedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 20;

        private var _isInitialized:Boolean = false;
        public var reason:uint = 99;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (20);
        }

        public function initIdentificationFailedMessage(reason:uint=99):IdentificationFailedMessage
        {
            this.reason = reason;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.reason = 99;
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
            this.serializeAs_IdentificationFailedMessage(output);
        }

        public function serializeAs_IdentificationFailedMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.reason);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdentificationFailedMessage(input);
        }

        public function deserializeAs_IdentificationFailedMessage(input:ICustomDataInput):void
        {
            this.reason = input.readByte();
            if (this.reason < 0)
            {
                throw (new Error((("Forbidden value (" + this.reason) + ") on element of IdentificationFailedMessage.reason.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

