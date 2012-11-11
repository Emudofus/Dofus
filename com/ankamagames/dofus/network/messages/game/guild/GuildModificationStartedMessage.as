package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class GuildModificationStartedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var canChangeName:Boolean = false;
        public var canChangeEmblem:Boolean = false;
        public static const protocolId:uint = 6324;

        public function GuildModificationStartedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6324;
        }// end function

        public function initGuildModificationStartedMessage(param1:Boolean = false, param2:Boolean = false) : GuildModificationStartedMessage
        {
            this.canChangeName = param1;
            this.canChangeEmblem = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.canChangeName = false;
            this.canChangeEmblem = false;
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
            this.serializeAs_GuildModificationStartedMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildModificationStartedMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.canChangeName);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.canChangeEmblem);
            param1.writeByte(_loc_2);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildModificationStartedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildModificationStartedMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.canChangeName = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.canChangeEmblem = BooleanByteWrapper.getFlag(_loc_2, 1);
            return;
        }// end function

    }
}
