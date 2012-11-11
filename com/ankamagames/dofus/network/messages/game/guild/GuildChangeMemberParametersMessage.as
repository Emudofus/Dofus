package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildChangeMemberParametersMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public var rank:uint = 0;
        public var experienceGivenPercent:uint = 0;
        public var rights:uint = 0;
        public static const protocolId:uint = 5549;

        public function GuildChangeMemberParametersMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5549;
        }// end function

        public function initGuildChangeMemberParametersMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : GuildChangeMemberParametersMessage
        {
            this.memberId = param1;
            this.rank = param2;
            this.experienceGivenPercent = param3;
            this.rights = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.memberId = 0;
            this.rank = 0;
            this.experienceGivenPercent = 0;
            this.rights = 0;
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
            this.serializeAs_GuildChangeMemberParametersMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildChangeMemberParametersMessage(param1:IDataOutput) : void
        {
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
            }
            param1.writeInt(this.memberId);
            if (this.rank < 0)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element rank.");
            }
            param1.writeShort(this.rank);
            if (this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
            {
                throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
            }
            param1.writeByte(this.experienceGivenPercent);
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element rights.");
            }
            param1.writeUnsignedInt(this.rights);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildChangeMemberParametersMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildChangeMemberParametersMessage(param1:IDataInput) : void
        {
            this.memberId = param1.readInt();
            if (this.memberId < 0)
            {
                throw new Error("Forbidden value (" + this.memberId + ") on element of GuildChangeMemberParametersMessage.memberId.");
            }
            this.rank = param1.readShort();
            if (this.rank < 0)
            {
                throw new Error("Forbidden value (" + this.rank + ") on element of GuildChangeMemberParametersMessage.rank.");
            }
            this.experienceGivenPercent = param1.readByte();
            if (this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
            {
                throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildChangeMemberParametersMessage.experienceGivenPercent.");
            }
            this.rights = param1.readUnsignedInt();
            if (this.rights < 0 || this.rights > 4294967295)
            {
                throw new Error("Forbidden value (" + this.rights + ") on element of GuildChangeMemberParametersMessage.rights.");
            }
            return;
        }// end function

    }
}
