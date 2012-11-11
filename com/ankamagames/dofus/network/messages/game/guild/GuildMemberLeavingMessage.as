package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildMemberLeavingMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var kicked:Boolean = false;
        public var memberId:int = 0;
        public static const protocolId:uint = 5923;

        public function GuildMemberLeavingMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5923;
        }// end function

        public function initGuildMemberLeavingMessage(param1:Boolean = false, param2:int = 0) : GuildMemberLeavingMessage
        {
            this.kicked = param1;
            this.memberId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.kicked = false;
            this.memberId = 0;
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
            this.serializeAs_GuildMemberLeavingMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildMemberLeavingMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.kicked);
            param1.writeInt(this.memberId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildMemberLeavingMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildMemberLeavingMessage(param1:IDataInput) : void
        {
            this.kicked = param1.readBoolean();
            this.memberId = param1.readInt();
            return;
        }// end function

    }
}
