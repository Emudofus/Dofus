package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationDetailsMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var partyType:uint = 0;
        public var fromId:uint = 0;
        public var fromName:String = "";
        public var leaderId:uint = 0;
        public var members:Vector.<PartyInvitationMemberInformations>;
        public static const protocolId:uint = 6263;

        public function PartyInvitationDetailsMessage()
        {
            this.members = new Vector.<PartyInvitationMemberInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6263;
        }// end function

        public function initPartyInvitationDetailsMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:String = "", param5:uint = 0, param6:Vector.<PartyInvitationMemberInformations> = null) : PartyInvitationDetailsMessage
        {
            super.initAbstractPartyMessage(param1);
            this.partyType = param2;
            this.fromId = param3;
            this.fromName = param4;
            this.leaderId = param5;
            this.members = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.partyType = 0;
            this.fromId = 0;
            this.fromName = "";
            this.leaderId = 0;
            this.members = new Vector.<PartyInvitationMemberInformations>;
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
            this.serializeAs_PartyInvitationDetailsMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationDetailsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            param1.writeByte(this.partyType);
            if (this.fromId < 0)
            {
                throw new Error("Forbidden value (" + this.fromId + ") on element fromId.");
            }
            param1.writeInt(this.fromId);
            param1.writeUTF(this.fromName);
            if (this.leaderId < 0)
            {
                throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
            }
            param1.writeInt(this.leaderId);
            param1.writeShort(this.members.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.members.length)
            {
                
                (this.members[_loc_2] as PartyInvitationMemberInformations).serializeAs_PartyInvitationMemberInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationDetailsMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationDetailsMessage(param1:IDataInput) : void
        {
            var _loc_4:PartyInvitationMemberInformations = null;
            super.deserialize(param1);
            this.partyType = param1.readByte();
            if (this.partyType < 0)
            {
                throw new Error("Forbidden value (" + this.partyType + ") on element of PartyInvitationDetailsMessage.partyType.");
            }
            this.fromId = param1.readInt();
            if (this.fromId < 0)
            {
                throw new Error("Forbidden value (" + this.fromId + ") on element of PartyInvitationDetailsMessage.fromId.");
            }
            this.fromName = param1.readUTF();
            this.leaderId = param1.readInt();
            if (this.leaderId < 0)
            {
                throw new Error("Forbidden value (" + this.leaderId + ") on element of PartyInvitationDetailsMessage.leaderId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new PartyInvitationMemberInformations();
                _loc_4.deserialize(param1);
                this.members.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
