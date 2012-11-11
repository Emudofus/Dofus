package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildCharacsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var charaTypeTarget:uint = 0;
        public static const protocolId:uint = 5706;

        public function GuildCharacsUpgradeRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5706;
        }// end function

        public function initGuildCharacsUpgradeRequestMessage(param1:uint = 0) : GuildCharacsUpgradeRequestMessage
        {
            this.charaTypeTarget = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.charaTypeTarget = 0;
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
            this.serializeAs_GuildCharacsUpgradeRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildCharacsUpgradeRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.charaTypeTarget);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildCharacsUpgradeRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildCharacsUpgradeRequestMessage(param1:IDataInput) : void
        {
            this.charaTypeTarget = param1.readByte();
            if (this.charaTypeTarget < 0)
            {
                throw new Error("Forbidden value (" + this.charaTypeTarget + ") on element of GuildCharacsUpgradeRequestMessage.charaTypeTarget.");
            }
            return;
        }// end function

    }
}
