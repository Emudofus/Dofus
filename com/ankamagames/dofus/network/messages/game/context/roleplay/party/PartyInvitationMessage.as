package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var partyType:uint = 0;
        public var maxParticipants:uint = 0;
        public var fromId:uint = 0;
        public var fromName:String = "";
        public var toId:uint = 0;
        public static const protocolId:uint = 5586;

        public function PartyInvitationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5586;
        }// end function

        public function initPartyInvitationMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:String = "", param6:uint = 0) : PartyInvitationMessage
        {
            super.initAbstractPartyMessage(param1);
            this.partyType = param2;
            this.maxParticipants = param3;
            this.fromId = param4;
            this.fromName = param5;
            this.toId = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.partyType = 0;
            this.maxParticipants = 0;
            this.fromId = 0;
            this.fromName = "";
            this.toId = 0;
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
            this.serializeAs_PartyInvitationMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            param1.writeByte(this.partyType);
            if (this.maxParticipants < 0)
            {
                throw new Error("Forbidden value (" + this.maxParticipants + ") on element maxParticipants.");
            }
            param1.writeByte(this.maxParticipants);
            if (this.fromId < 0)
            {
                throw new Error("Forbidden value (" + this.fromId + ") on element fromId.");
            }
            param1.writeInt(this.fromId);
            param1.writeUTF(this.fromName);
            if (this.toId < 0)
            {
                throw new Error("Forbidden value (" + this.toId + ") on element toId.");
            }
            param1.writeInt(this.toId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.partyType = param1.readByte();
            if (this.partyType < 0)
            {
                throw new Error("Forbidden value (" + this.partyType + ") on element of PartyInvitationMessage.partyType.");
            }
            this.maxParticipants = param1.readByte();
            if (this.maxParticipants < 0)
            {
                throw new Error("Forbidden value (" + this.maxParticipants + ") on element of PartyInvitationMessage.maxParticipants.");
            }
            this.fromId = param1.readInt();
            if (this.fromId < 0)
            {
                throw new Error("Forbidden value (" + this.fromId + ") on element of PartyInvitationMessage.fromId.");
            }
            this.fromName = param1.readUTF();
            this.toId = param1.readInt();
            if (this.toId < 0)
            {
                throw new Error("Forbidden value (" + this.toId + ") on element of PartyInvitationMessage.toId.");
            }
            return;
        }// end function

    }
}
