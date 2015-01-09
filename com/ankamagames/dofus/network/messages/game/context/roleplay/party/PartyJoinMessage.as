package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class PartyJoinMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5576;

        private var _isInitialized:Boolean = false;
        public var partyType:uint = 0;
        public var partyLeaderId:uint = 0;
        public var maxParticipants:uint = 0;
        public var members:Vector.<PartyMemberInformations>;
        public var guests:Vector.<PartyGuestInformations>;
        public var restricted:Boolean = false;
        public var partyName:String = "";

        public function PartyJoinMessage()
        {
            this.members = new Vector.<PartyMemberInformations>();
            this.guests = new Vector.<PartyGuestInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5576);
        }

        public function initPartyJoinMessage(partyId:uint=0, partyType:uint=0, partyLeaderId:uint=0, maxParticipants:uint=0, members:Vector.<PartyMemberInformations>=null, guests:Vector.<PartyGuestInformations>=null, restricted:Boolean=false, partyName:String=""):PartyJoinMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.partyType = partyType;
            this.partyLeaderId = partyLeaderId;
            this.maxParticipants = maxParticipants;
            this.members = members;
            this.guests = guests;
            this.restricted = restricted;
            this.partyName = partyName;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.partyType = 0;
            this.partyLeaderId = 0;
            this.maxParticipants = 0;
            this.members = new Vector.<PartyMemberInformations>();
            this.guests = new Vector.<PartyGuestInformations>();
            this.restricted = false;
            this.partyName = "";
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_PartyJoinMessage(output);
        }

        public function serializeAs_PartyJoinMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeByte(this.partyType);
            if (this.partyLeaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyLeaderId) + ") on element partyLeaderId.")));
            };
            output.writeInt(this.partyLeaderId);
            if (this.maxParticipants < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxParticipants) + ") on element maxParticipants.")));
            };
            output.writeByte(this.maxParticipants);
            output.writeShort(this.members.length);
            var _i4:uint;
            while (_i4 < this.members.length)
            {
                output.writeShort((this.members[_i4] as PartyMemberInformations).getTypeId());
                (this.members[_i4] as PartyMemberInformations).serialize(output);
                _i4++;
            };
            output.writeShort(this.guests.length);
            var _i5:uint;
            while (_i5 < this.guests.length)
            {
                (this.guests[_i5] as PartyGuestInformations).serializeAs_PartyGuestInformations(output);
                _i5++;
            };
            output.writeBoolean(this.restricted);
            output.writeUTF(this.partyName);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyJoinMessage(input);
        }

        public function deserializeAs_PartyJoinMessage(input:IDataInput):void
        {
            var _id4:uint;
            var _item4:PartyMemberInformations;
            var _item5:PartyGuestInformations;
            super.deserialize(input);
            this.partyType = input.readByte();
            if (this.partyType < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyType) + ") on element of PartyJoinMessage.partyType.")));
            };
            this.partyLeaderId = input.readInt();
            if (this.partyLeaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyLeaderId) + ") on element of PartyJoinMessage.partyLeaderId.")));
            };
            this.maxParticipants = input.readByte();
            if (this.maxParticipants < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxParticipants) + ") on element of PartyJoinMessage.maxParticipants.")));
            };
            var _membersLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _membersLen)
            {
                _id4 = input.readUnsignedShort();
                _item4 = ProtocolTypeManager.getInstance(PartyMemberInformations, _id4);
                _item4.deserialize(input);
                this.members.push(_item4);
                _i4++;
            };
            var _guestsLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _guestsLen)
            {
                _item5 = new PartyGuestInformations();
                _item5.deserialize(input);
                this.guests.push(_item5);
                _i5++;
            };
            this.restricted = input.readBoolean();
            this.partyName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

