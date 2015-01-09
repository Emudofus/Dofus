package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ContactLookRequestByIdMessage extends ContactLookRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5935;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5935);
        }

        public function initContactLookRequestByIdMessage(requestId:uint=0, contactType:uint=0, playerId:uint=0):ContactLookRequestByIdMessage
        {
            super.initContactLookRequestMessage(requestId, contactType);
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.playerId = 0;
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
            this.serializeAs_ContactLookRequestByIdMessage(output);
        }

        public function serializeAs_ContactLookRequestByIdMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ContactLookRequestMessage(output);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ContactLookRequestByIdMessage(input);
        }

        public function deserializeAs_ContactLookRequestByIdMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of ContactLookRequestByIdMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.social

