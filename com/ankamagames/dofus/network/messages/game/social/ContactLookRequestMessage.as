package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ContactLookRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5932;

        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public var contactType:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5932);
        }

        public function initContactLookRequestMessage(requestId:uint=0, contactType:uint=0):ContactLookRequestMessage
        {
            this.requestId = requestId;
            this.contactType = contactType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.requestId = 0;
            this.contactType = 0;
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
            this.serializeAs_ContactLookRequestMessage(output);
        }

        public function serializeAs_ContactLookRequestMessage(output:ICustomDataOutput):void
        {
            if ((((this.requestId < 0)) || ((this.requestId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element requestId.")));
            };
            output.writeByte(this.requestId);
            output.writeByte(this.contactType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ContactLookRequestMessage(input);
        }

        public function deserializeAs_ContactLookRequestMessage(input:ICustomDataInput):void
        {
            this.requestId = input.readUnsignedByte();
            if ((((this.requestId < 0)) || ((this.requestId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element of ContactLookRequestMessage.requestId.")));
            };
            this.contactType = input.readByte();
            if (this.contactType < 0)
            {
                throw (new Error((("Forbidden value (" + this.contactType) + ") on element of ContactLookRequestMessage.contactType.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.social

