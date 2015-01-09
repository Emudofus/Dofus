package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseGuildRightsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5703;

        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public var guildInfo:GuildInformations;
        public var rights:uint = 0;

        public function HouseGuildRightsMessage()
        {
            this.guildInfo = new GuildInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5703);
        }

        public function initHouseGuildRightsMessage(houseId:uint=0, guildInfo:GuildInformations=null, rights:uint=0):HouseGuildRightsMessage
        {
            this.houseId = houseId;
            this.guildInfo = guildInfo;
            this.rights = rights;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houseId = 0;
            this.guildInfo = new GuildInformations();
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
            this.serializeAs_HouseGuildRightsMessage(output);
        }

        public function serializeAs_HouseGuildRightsMessage(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeVarShort(this.houseId);
            this.guildInfo.serializeAs_GuildInformations(output);
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element rights.")));
            };
            output.writeVarInt(this.rights);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseGuildRightsMessage(input);
        }

        public function deserializeAs_HouseGuildRightsMessage(input:ICustomDataInput):void
        {
            this.houseId = input.readVarUhShort();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseGuildRightsMessage.houseId.")));
            };
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(input);
            this.rights = input.readVarUhInt();
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element of HouseGuildRightsMessage.rights.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild

