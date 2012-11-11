package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildFightLeaveRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var taxCollectorId:int = 0;
        public var characterId:uint = 0;
        public static const protocolId:uint = 5715;

        public function GuildFightLeaveRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5715;
        }// end function

        public function initGuildFightLeaveRequestMessage(param1:int = 0, param2:uint = 0) : GuildFightLeaveRequestMessage
        {
            this.taxCollectorId = param1;
            this.characterId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.taxCollectorId = 0;
            this.characterId = 0;
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
            this.serializeAs_GuildFightLeaveRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildFightLeaveRequestMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.taxCollectorId);
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            param1.writeInt(this.characterId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildFightLeaveRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildFightLeaveRequestMessage(param1:IDataInput) : void
        {
            this.taxCollectorId = param1.readInt();
            this.characterId = param1.readInt();
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element of GuildFightLeaveRequestMessage.characterId.");
            }
            return;
        }// end function

    }
}
