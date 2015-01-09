package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceChangeGuildRightsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6426;

        private var _isInitialized:Boolean = false;
        public var guildId:uint = 0;
        public var rights:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6426);
        }

        public function initAllianceChangeGuildRightsMessage(guildId:uint=0, rights:uint=0):AllianceChangeGuildRightsMessage
        {
            this.guildId = guildId;
            this.rights = rights;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildId = 0;
            this.rights = 0;
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
            this.serializeAs_AllianceChangeGuildRightsMessage(output);
        }

        public function serializeAs_AllianceChangeGuildRightsMessage(output:ICustomDataOutput):void
        {
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element guildId.")));
            };
            output.writeVarInt(this.guildId);
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element rights.")));
            };
            output.writeByte(this.rights);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceChangeGuildRightsMessage(input);
        }

        public function deserializeAs_AllianceChangeGuildRightsMessage(input:ICustomDataInput):void
        {
            this.guildId = input.readVarUhInt();
            if (this.guildId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildId) + ") on element of AllianceChangeGuildRightsMessage.guildId.")));
            };
            this.rights = input.readByte();
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element of AllianceChangeGuildRightsMessage.rights.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

