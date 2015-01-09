package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyCancelInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6251;

        private var _isInitialized:Boolean = false;
        public var cancelerId:uint = 0;
        public var guestId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6251);
        }

        public function initPartyCancelInvitationNotificationMessage(partyId:uint=0, cancelerId:uint=0, guestId:uint=0):PartyCancelInvitationNotificationMessage
        {
            super.initAbstractPartyEventMessage(partyId);
            this.cancelerId = cancelerId;
            this.guestId = guestId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.cancelerId = 0;
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
            this.serializeAs_PartyCancelInvitationNotificationMessage(output);
        }

        public function serializeAs_PartyCancelInvitationNotificationMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractPartyEventMessage(output);
            if (this.cancelerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cancelerId) + ") on element cancelerId.")));
            };
            output.writeVarInt(this.cancelerId);
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element guestId.")));
            };
            output.writeVarInt(this.guestId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyCancelInvitationNotificationMessage(input);
        }

        public function deserializeAs_PartyCancelInvitationNotificationMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.cancelerId = input.readVarUhInt();
            if (this.cancelerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cancelerId) + ") on element of PartyCancelInvitationNotificationMessage.cancelerId.")));
            };
            this.guestId = input.readVarUhInt();
            if (this.guestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.guestId) + ") on element of PartyCancelInvitationNotificationMessage.guestId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

