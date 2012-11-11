package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseGuildRightsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public var guildInfo:GuildInformations;
        public var rights:uint = 0;
        public static const protocolId:uint = 5703;

        public function HouseGuildRightsMessage()
        {
            this.guildInfo = new GuildInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5703;
        }// end function

        public function initHouseGuildRightsMessage(param1:uint = 0, param2:GuildInformations = null, param3:uint = 0) : HouseGuildRightsMessage
        {
            this.houseId = param1;
            this.guildInfo = param2;
            this.rights = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.houseId = 0;
            this.guildInfo = new GuildInformations();
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HouseGuildRightsMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseGuildRightsMessage(param1:IDataOutput) : void
        {
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
            }
            param1.writeShort(this.houseId);
            this.guildInfo.serializeAs_GuildInformations(param1);
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element rights.");
            }
            param1.writeUnsignedInt(this.rights);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseGuildRightsMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseGuildRightsMessage(param1:IDataInput) : void
        {
            this.houseId = param1.readShort();
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildRightsMessage.houseId.");
            }
            this.guildInfo = new GuildInformations();
            this.guildInfo.deserialize(param1);
            this.rights = param1.readUnsignedInt();
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildRightsMessage.rights.");
            }
            return;
        }// end function

    }
}
