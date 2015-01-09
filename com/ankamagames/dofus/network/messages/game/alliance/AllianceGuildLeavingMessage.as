package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceGuildLeavingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6399;

        private var _isInitialized:Boolean = false;
        public var kicked:Boolean = false;
        public var guildId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6399);
        }

        public function initAllianceGuildLeavingMessage(kicked:Boolean=false, guildId:uint=0):AllianceGuildLeavingMessage
        {
            this.kicked = kicked;
            this.guildId = guildId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.kicked = false;
            this.guildId = 0;
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
            this.serializeAs_AllianceGuildLeavingMessage(output);
        }

        public function serializeAs_AllianceGuildLeavingMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.kicked);
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element guildId.")));
            };
            output.writeVarInt(this.guildId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceGuildLeavingMessage(input);
        }

        public function deserializeAs_AllianceGuildLeavingMessage(input:ICustomDataInput):void
        {
            this.kicked = input.readBoolean();
            this.guildId = input.readVarUhInt();
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element of AllianceGuildLeavingMessage.guildId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

