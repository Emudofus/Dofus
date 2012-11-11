package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildLevelUpMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var newLevel:uint = 0;
        public static const protocolId:uint = 6062;

        public function GuildLevelUpMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6062;
        }// end function

        public function initGuildLevelUpMessage(param1:uint = 0) : GuildLevelUpMessage
        {
            this.newLevel = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.newLevel = 0;
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
            this.serializeAs_GuildLevelUpMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildLevelUpMessage(param1:IDataOutput) : void
        {
            if (this.newLevel < 2 || this.newLevel > 200)
            {
                throw new Error("Forbidden value (" + this.newLevel + ") on element newLevel.");
            }
            param1.writeByte(this.newLevel);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildLevelUpMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildLevelUpMessage(param1:IDataInput) : void
        {
            this.newLevel = param1.readUnsignedByte();
            if (this.newLevel < 2 || this.newLevel > 200)
            {
                throw new Error("Forbidden value (" + this.newLevel + ") on element of GuildLevelUpMessage.newLevel.");
            }
            return;
        }// end function

    }
}
