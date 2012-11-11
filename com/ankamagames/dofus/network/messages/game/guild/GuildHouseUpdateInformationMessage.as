package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildHouseUpdateInformationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var housesInformations:HouseInformationsForGuild;
        public static const protocolId:uint = 6181;

        public function GuildHouseUpdateInformationMessage()
        {
            this.housesInformations = new HouseInformationsForGuild();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6181;
        }// end function

        public function initGuildHouseUpdateInformationMessage(param1:HouseInformationsForGuild = null) : GuildHouseUpdateInformationMessage
        {
            this.housesInformations = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.housesInformations = new HouseInformationsForGuild();
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
            this.serializeAs_GuildHouseUpdateInformationMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildHouseUpdateInformationMessage(param1:IDataOutput) : void
        {
            this.housesInformations.serializeAs_HouseInformationsForGuild(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildHouseUpdateInformationMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildHouseUpdateInformationMessage(param1:IDataInput) : void
        {
            this.housesInformations = new HouseInformationsForGuild();
            this.housesInformations.deserialize(param1);
            return;
        }// end function

    }
}
