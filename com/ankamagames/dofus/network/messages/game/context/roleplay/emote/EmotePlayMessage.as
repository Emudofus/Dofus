package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class EmotePlayMessage extends EmotePlayAbstractMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5683;

        private var _isInitialized:Boolean = false;
        public var actorId:int = 0;
        public var accountId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5683);
        }

        public function initEmotePlayMessage(emoteId:uint=0, emoteStartTime:Number=0, actorId:int=0, accountId:uint=0):EmotePlayMessage
        {
            super.initEmotePlayAbstractMessage(emoteId, emoteStartTime);
            this.actorId = actorId;
            this.accountId = accountId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.actorId = 0;
            this.accountId = 0;
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
            this.serializeAs_EmotePlayMessage(output);
        }

        public function serializeAs_EmotePlayMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_EmotePlayAbstractMessage(output);
            output.writeInt(this.actorId);
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EmotePlayMessage(input);
        }

        public function deserializeAs_EmotePlayMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.actorId = input.readInt();
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of EmotePlayMessage.accountId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.emote

