package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ContactLookErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6045;

        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6045);
        }

        public function initContactLookErrorMessage(requestId:uint=0):ContactLookErrorMessage
        {
            this.requestId = requestId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.requestId = 0;
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
            this.serializeAs_ContactLookErrorMessage(output);
        }

        public function serializeAs_ContactLookErrorMessage(output:ICustomDataOutput):void
        {
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element requestId.")));
            };
            output.writeVarInt(this.requestId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ContactLookErrorMessage(input);
        }

        public function deserializeAs_ContactLookErrorMessage(input:ICustomDataInput):void
        {
            this.requestId = input.readVarUhInt();
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element of ContactLookErrorMessage.requestId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.social

