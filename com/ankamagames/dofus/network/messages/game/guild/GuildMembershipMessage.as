package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildMembershipMessage extends GuildJoinedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 5835;

        public function GuildMembershipMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5835;
        }// end function

        public function initGuildMembershipMessage(param1:GuildInformations = null, param2:uint = 0, param3:Boolean = false) : GuildMembershipMessage
        {
            super.initGuildJoinedMessage(param1, param2, param3);
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
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
            this.serializeAs_GuildMembershipMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildMembershipMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GuildJoinedMessage(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildMembershipMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildMembershipMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
