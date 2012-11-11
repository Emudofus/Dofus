package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildUIOpenedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public static const protocolId:uint = 5561;

        public function GuildUIOpenedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5561;
        }// end function

        public function initGuildUIOpenedMessage(param1:uint = 0) : GuildUIOpenedMessage
        {
            this.type = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.type = 0;
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
            this.serializeAs_GuildUIOpenedMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildUIOpenedMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.type);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildUIOpenedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildUIOpenedMessage(param1:IDataInput) : void
        {
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of GuildUIOpenedMessage.type.");
            }
            return;
        }// end function

    }
}
