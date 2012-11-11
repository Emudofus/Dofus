package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationDungeonMessage extends PartyInvitationMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public static const protocolId:uint = 6244;

        public function PartyInvitationDungeonMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6244;
        }// end function

        public function initPartyInvitationDungeonMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:String = "", param6:uint = 0, param7:uint = 0) : PartyInvitationDungeonMessage
        {
            super.initPartyInvitationMessage(param1, param2, param3, param4, param5, param6);
            this.dungeonId = param7;
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
            this.serializeAs_PartyInvitationDungeonMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationDungeonMessage(param1:IDataOutput) : void
        {
            super.serializeAs_PartyInvitationMessage(param1);
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationDungeonMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationDungeonMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonMessage.dungeonId.");
            }
            return;
        }// end function

    }
}
