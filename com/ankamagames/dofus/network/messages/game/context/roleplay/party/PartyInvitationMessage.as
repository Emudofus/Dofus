package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyInvitationMessage extends AbstractPartyMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5586;

        private var _isInitialized:Boolean = false;
        public var partyType:uint = 0;
        public var partyName:String = "";
        public var maxParticipants:uint = 0;
        public var fromId:uint = 0;
        public var fromName:String = "";
        public var toId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5586);
        }

        public function initPartyInvitationMessage(partyId:uint=0, partyType:uint=0, partyName:String="", maxParticipants:uint=0, fromId:uint=0, fromName:String="", toId:uint=0):PartyInvitationMessage
        {
            super.initAbstractPartyMessage(partyId);
            this.partyType = partyType;
            this.partyName = partyName;
            this.maxParticipants = maxParticipants;
            this.fromId = fromId;
            this.fromName = fromName;
            this.toId = toId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.partyType = 0;
            this.partyName = "";
            this.maxParticipants = 0;
            this.fromId = 0;
            this.fromName = "";
            this.toId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyInvitationMessage(output);
        }

        public function serializeAs_PartyInvitationMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyMessage(output);
            output.writeByte(this.partyType);
            output.writeUTF(this.partyName);
            if (this.maxParticipants < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxParticipants) + ") on element maxParticipants.")));
            };
            output.writeByte(this.maxParticipants);
            if (this.fromId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fromId) + ") on element fromId.")));
            };
            output.writeVarInt(this.fromId);
            output.writeUTF(this.fromName);
            if (this.toId < 0)
            {
                throw (new Error((("Forbidden value (" + this.toId) + ") on element toId.")));
            };
            output.writeVarInt(this.toId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyInvitationMessage(input);
        }

        public function deserializeAs_PartyInvitationMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.partyType = input.readByte();
            if (this.partyType < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyType) + ") on element of PartyInvitationMessage.partyType.")));
            };
            this.partyName = input.readUTF();
            this.maxParticipants = input.readByte();
            if (this.maxParticipants < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxParticipants) + ") on element of PartyInvitationMessage.maxParticipants.")));
            };
            this.fromId = input.readVarUhInt();
            if (this.fromId < 0)
            {
                throw (new Error((("Forbidden value (" + this.fromId) + ") on element of PartyInvitationMessage.fromId.")));
            };
            this.fromName = input.readUTF();
            this.toId = input.readVarUhInt();
            if (this.toId < 0)
            {
                throw (new Error((("Forbidden value (" + this.toId) + ") on element of PartyInvitationMessage.toId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

