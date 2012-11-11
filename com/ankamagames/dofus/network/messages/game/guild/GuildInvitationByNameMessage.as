package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInvitationByNameMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public static const protocolId:uint = 6115;

        public function GuildInvitationByNameMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6115;
        }// end function

        public function initGuildInvitationByNameMessage(param1:String = "") : GuildInvitationByNameMessage
        {
            this.name = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.name = "";
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
            this.serializeAs_GuildInvitationByNameMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInvitationByNameMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.name);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInvitationByNameMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInvitationByNameMessage(param1:IDataInput) : void
        {
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
