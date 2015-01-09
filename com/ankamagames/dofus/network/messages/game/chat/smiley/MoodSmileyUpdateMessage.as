package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MoodSmileyUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6388;

        private var _isInitialized:Boolean = false;
        public var accountId:uint = 0;
        public var playerId:uint = 0;
        public var smileyId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6388);
        }

        public function initMoodSmileyUpdateMessage(accountId:uint=0, playerId:uint=0, smileyId:int=0):MoodSmileyUpdateMessage
        {
            this.accountId = accountId;
            this.playerId = playerId;
            this.smileyId = smileyId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accountId = 0;
            this.playerId = 0;
            this.smileyId = 0;
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
            this.serializeAs_MoodSmileyUpdateMessage(output);
        }

        public function serializeAs_MoodSmileyUpdateMessage(output:ICustomDataOutput):void
        {
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            output.writeByte(this.smileyId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MoodSmileyUpdateMessage(input);
        }

        public function deserializeAs_MoodSmileyUpdateMessage(input:ICustomDataInput):void
        {
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of MoodSmileyUpdateMessage.accountId.")));
            };
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of MoodSmileyUpdateMessage.playerId.")));
            };
            this.smileyId = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat.smiley

