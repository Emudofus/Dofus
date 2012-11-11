package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildKickRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var kickedId:uint = 0;
        public static const protocolId:uint = 5887;

        public function GuildKickRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5887;
        }// end function

        public function initGuildKickRequestMessage(param1:uint = 0) : GuildKickRequestMessage
        {
            this.kickedId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.kickedId = 0;
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
            this.serializeAs_GuildKickRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildKickRequestMessage(param1:IDataOutput) : void
        {
            if (this.kickedId < 0)
            {
                throw new Error("Forbidden value (" + this.kickedId + ") on element kickedId.");
            }
            param1.writeInt(this.kickedId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildKickRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildKickRequestMessage(param1:IDataInput) : void
        {
            this.kickedId = param1.readInt();
            if (this.kickedId < 0)
            {
                throw new Error("Forbidden value (" + this.kickedId + ") on element of GuildKickRequestMessage.kickedId.");
            }
            return;
        }// end function

    }
}
