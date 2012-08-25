package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyJoinMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var partyType:uint = 0;
        public var partyLeaderId:uint = 0;
        public var maxParticipants:uint = 0;
        public var members:Vector.<PartyMemberInformations>;
        public var guests:Vector.<PartyGuestInformations>;
        public var restricted:Boolean = false;
        public static const protocolId:uint = 5576;

        public function PartyJoinMessage()
        {
            this.members = new Vector.<PartyMemberInformations>;
            this.guests = new Vector.<PartyGuestInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5576;
        }// end function

        public function initPartyJoinMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:Vector.<PartyMemberInformations> = null, param6:Vector.<PartyGuestInformations> = null, param7:Boolean = false) : PartyJoinMessage
        {
            super.initAbstractPartyMessage(param1);
            this.partyType = param2;
            this.partyLeaderId = param3;
            this.maxParticipants = param4;
            this.members = param5;
            this.guests = param6;
            this.restricted = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.partyType = 0;
            this.partyLeaderId = 0;
            this.maxParticipants = 0;
            this.members = new Vector.<PartyMemberInformations>;
            this.guests = new Vector.<PartyGuestInformations>;
            this.restricted = false;
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
            this.serializeAs_PartyJoinMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyJoinMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            param1.writeByte(this.partyType);
            if (this.partyLeaderId < 0)
            {
                throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
            }
            param1.writeInt(this.partyLeaderId);
            if (this.maxParticipants < 0)
            {
                throw new Error("Forbidden value (" + this.maxParticipants + ") on element maxParticipants.");
            }
            param1.writeByte(this.maxParticipants);
            param1.writeShort(this.members.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.members.length)
            {
                
                param1.writeShort((this.members[_loc_2] as PartyMemberInformations).getTypeId());
                (this.members[_loc_2] as PartyMemberInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.guests.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.guests.length)
            {
                
                (this.guests[_loc_3] as PartyGuestInformations).serializeAs_PartyGuestInformations(param1);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeBoolean(this.restricted);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyJoinMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyJoinMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:PartyMemberInformations = null;
            var _loc_8:PartyGuestInformations = null;
            super.deserialize(param1);
            this.partyType = param1.readByte();
            if (this.partyType < 0)
            {
                throw new Error("Forbidden value (" + this.partyType + ") on element of PartyJoinMessage.partyType.");
            }
            this.partyLeaderId = param1.readInt();
            if (this.partyLeaderId < 0)
            {
                throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyJoinMessage.partyLeaderId.");
            }
            this.maxParticipants = param1.readByte();
            if (this.maxParticipants < 0)
            {
                throw new Error("Forbidden value (" + this.maxParticipants + ") on element of PartyJoinMessage.maxParticipants.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readUnsignedShort();
                _loc_7 = ProtocolTypeManager.getInstance(PartyMemberInformations, _loc_6);
                _loc_7.deserialize(param1);
                this.members.push(_loc_7);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = new PartyGuestInformations();
                _loc_8.deserialize(param1);
                this.guests.push(_loc_8);
                _loc_5 = _loc_5 + 1;
            }
            this.restricted = param1.readBoolean();
            return;
        }// end function

    }
}
