package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildFightTakePlaceRequestMessage extends GuildFightJoinRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var replacedCharacterId:int = 0;
        public static const protocolId:uint = 6235;

        public function GuildFightTakePlaceRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6235;
        }// end function

        public function initGuildFightTakePlaceRequestMessage(param1:int = 0, param2:int = 0) : GuildFightTakePlaceRequestMessage
        {
            super.initGuildFightJoinRequestMessage(param1);
            this.replacedCharacterId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.replacedCharacterId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GuildFightTakePlaceRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildFightTakePlaceRequestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GuildFightJoinRequestMessage(param1);
            param1.writeInt(this.replacedCharacterId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildFightTakePlaceRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildFightTakePlaceRequestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.replacedCharacterId = param1.readInt();
            return;
        }// end function

    }
}
