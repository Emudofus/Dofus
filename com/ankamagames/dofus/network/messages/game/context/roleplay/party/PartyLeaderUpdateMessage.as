package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyLeaderUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5578;

        private var _isInitialized:Boolean = false;
        public var partyLeaderId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5578);
        }

        public function initPartyLeaderUpdateMessage(partyId:uint=0, partyLeaderId:uint=0):PartyLeaderUpdateMessage
        {
            super.initAbstractPartyEventMessage(partyId);
            this.partyLeaderId = partyLeaderId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.partyLeaderId = 0;
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
            this.serializeAs_PartyLeaderUpdateMessage(output);
        }

        public function serializeAs_PartyLeaderUpdateMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyEventMessage(output);
            if (this.partyLeaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyLeaderId) + ") on element partyLeaderId.")));
            };
            output.writeVarInt(this.partyLeaderId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyLeaderUpdateMessage(input);
        }

        public function deserializeAs_PartyLeaderUpdateMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.partyLeaderId = input.readVarUhInt();
            if (this.partyLeaderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.partyLeaderId) + ") on element of PartyLeaderUpdateMessage.partyLeaderId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

