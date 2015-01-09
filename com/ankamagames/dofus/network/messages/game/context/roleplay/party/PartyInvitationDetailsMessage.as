package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class PartyInvitationDetailsMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6263;

        private var _isInitialized:Boolean = false;
        public var partyType:uint = 0;
        public var partyName:String = "";
        public var fromId:uint = 0;
        public var fromName:String = "";
        public var leaderId:uint = 0;
        public var members:Vector.<PartyInvitationMemberInformations>;
        public var guests:Vector.<PartyGuestInformations>;

        public function PartyInvitationDetailsMessage()
        {
            this.members = new Vector.<PartyInvitationMemberInformations>();
            this.guests = new Vector.<PartyGuestInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6263);
        }

        public function initPartyInvitationDetailsMessage(partyId:uint=0, partyType:uint=0, partyName:String="", fromId:uint=0, fromName:String="", leaderId:uint=0, members:Vector.<PartyInvitationMemberInformations>=null, guests:Vector.<PartyGuestInformations>=null):PartyInvitationDetailsMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.partyType = partyType;
            this.partyName = partyName;
            this.fromId = fromId;
            this.fromName = fromName;
            this.leaderId = leaderId;
            this.members = members;
            this.guests = guests;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.partyType = 0;
            this.partyName = "";
            this.fromId = 0;
            this.fromName = "";
            this.leaderId = 0;
            this.members = new Vector.<PartyInvitationMemberInformations>();
            this.guests = new Vector.<PartyGuestInformations>();
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
            this.serializeAs_PartyInvitationDetailsMessage(output);
        }

        public function serializeAs_PartyInvitationDetailsMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeByte(this.partyType);
            output.writeUTF(this.partyName);
            if (this.fromId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fromId) + ") on element fromId.")));
            };
            output.writeInt(this.fromId);
            output.writeUTF(this.fromName);
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element leaderId.")));
            };
            output.writeInt(this.leaderId);
            output.writeShort(this.members.length);
            var _i6:uint;
            while (_i6 < this.members.length)
            {
                (this.members[_i6] as PartyInvitationMemberInformations).serializeAs_PartyInvitationMemberInformations(output);
                _i6++;
            };
            output.writeShort(this.guests.length);
            var _i7:uint;
            while (_i7 < this.guests.length)
            {
                (this.guests[_i7] as PartyGuestInformations).serializeAs_PartyGuestInformations(output);
                _i7++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyInvitationDetailsMessage(input);
        }

        public function deserializeAs_PartyInvitationDetailsMessage(input:IDataInput):void
        {
            var _item6:PartyInvitationMemberInformations;
            var _item7:PartyGuestInformations;
            super.deserialize(input);
            this.partyType = input.readByte();
            if (this.partyType < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyType) + ") on element of PartyInvitationDetailsMessage.partyType.")));
            };
            this.partyName = input.readUTF();
            this.fromId = input.readInt();
            if (this.fromId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fromId) + ") on element of PartyInvitationDetailsMessage.fromId.")));
            };
            this.fromName = input.readUTF();
            this.leaderId = input.readInt();
            if (this.leaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.leaderId) + ") on element of PartyInvitationDetailsMessage.leaderId.")));
            };
            var _membersLen:uint = input.readUnsignedShort();
            var _i6:uint;
            while (_i6 < _membersLen)
            {
                _item6 = new PartyInvitationMemberInformations();
                _item6.deserialize(input);
                this.members.push(_item6);
                _i6++;
            };
            var _guestsLen:uint = input.readUnsignedShort();
            var _i7:uint;
            while (_i7 < _guestsLen)
            {
                _item7 = new PartyGuestInformations();
                _item7.deserialize(input);
                this.guests.push(_item7);
                _i7++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

