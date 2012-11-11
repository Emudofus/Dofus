package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationDungeonRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public static const protocolId:uint = 6245;

        public function PartyInvitationDungeonRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6245;
        }// end function

        public function initPartyInvitationDungeonRequestMessage(param1:String = "", param2:uint = 0) : PartyInvitationDungeonRequestMessage
        {
            super.initPartyInvitationRequestMessage(param1);
            this.dungeonId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.dungeonId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyInvitationDungeonRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationDungeonRequestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_PartyInvitationRequestMessage(param1);
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationDungeonRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationDungeonRequestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonRequestMessage.dungeonId.");
            }
            return;
        }// end function

    }
}
