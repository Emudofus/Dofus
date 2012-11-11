package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildHouseTeleportRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;
        public static const protocolId:uint = 5712;

        public function GuildHouseTeleportRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5712;
        }// end function

        public function initGuildHouseTeleportRequestMessage(param1:uint = 0) : GuildHouseTeleportRequestMessage
        {
            this.houseId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.houseId = 0;
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
            this.serializeAs_GuildHouseTeleportRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildHouseTeleportRequestMessage(param1:IDataOutput) : void
        {
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
            }
            param1.writeInt(this.houseId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildHouseTeleportRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildHouseTeleportRequestMessage(param1:IDataInput) : void
        {
            this.houseId = param1.readInt();
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element of GuildHouseTeleportRequestMessage.houseId.");
            }
            return;
        }// end function

    }
}
