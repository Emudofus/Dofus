package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyRefuseInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guestId:uint = 0;
        public static const protocolId:uint = 5596;

        public function PartyRefuseInvitationNotificationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5596;
        }// end function

        public function initPartyRefuseInvitationNotificationMessage(param1:uint = 0, param2:uint = 0) : PartyRefuseInvitationNotificationMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.guestId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.guestId = 0;
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
            this.serializeAs_PartyRefuseInvitationNotificationMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyRefuseInvitationNotificationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
            }
            param1.writeInt(this.guestId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyRefuseInvitationNotificationMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyRefuseInvitationNotificationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guestId = param1.readInt();
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element of PartyRefuseInvitationNotificationMessage.guestId.");
            }
            return;
        }// end function

    }
}
