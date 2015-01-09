package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyRefuseInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5596;

        private var _isInitialized:Boolean = false;
        public var guestId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5596);
        }

        public function initPartyRefuseInvitationNotificationMessage(partyId:uint=0, guestId:uint=0):PartyRefuseInvitationNotificationMessage
        {
            super.initAbstractPartyEventMessage(partyId);
            this.guestId = guestId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.guestId = 0;
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
            this.serializeAs_PartyRefuseInvitationNotificationMessage(output);
        }

        public function serializeAs_PartyRefuseInvitationNotificationMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyEventMessage(output);
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element guestId.")));
            };
            output.writeVarInt(this.guestId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyRefuseInvitationNotificationMessage(input);
        }

        public function deserializeAs_PartyRefuseInvitationNotificationMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.guestId = input.readVarUhInt();
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element of PartyRefuseInvitationNotificationMessage.guestId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

