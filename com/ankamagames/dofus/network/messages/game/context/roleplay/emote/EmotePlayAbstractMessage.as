package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class EmotePlayAbstractMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5690;

        private var _isInitialized:Boolean = false;
        public var emoteId:uint = 0;
        public var emoteStartTime:Number = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5690);
        }

        public function initEmotePlayAbstractMessage(emoteId:uint=0, emoteStartTime:Number=0):EmotePlayAbstractMessage
        {
            this.emoteId = emoteId;
            this.emoteStartTime = emoteStartTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.emoteId = 0;
            this.emoteStartTime = 0;
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
            this.serializeAs_EmotePlayAbstractMessage(output);
        }

        public function serializeAs_EmotePlayAbstractMessage(output:ICustomDataOutput):void
        {
            if ((((this.emoteId < 0)) || ((this.emoteId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.emoteId) + ") on element emoteId.")));
            };
            output.writeByte(this.emoteId);
            if ((((this.emoteStartTime < -9007199254740992)) || ((this.emoteStartTime > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.emoteStartTime) + ") on element emoteStartTime.")));
            };
            output.writeDouble(this.emoteStartTime);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EmotePlayAbstractMessage(input);
        }

        public function deserializeAs_EmotePlayAbstractMessage(input:ICustomDataInput):void
        {
            this.emoteId = input.readUnsignedByte();
            if ((((this.emoteId < 0)) || ((this.emoteId > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.emoteId) + ") on element of EmotePlayAbstractMessage.emoteId.")));
            };
            this.emoteStartTime = input.readDouble();
            if ((((this.emoteStartTime < -9007199254740992)) || ((this.emoteStartTime > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.emoteStartTime) + ") on element of EmotePlayAbstractMessage.emoteStartTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.emote

