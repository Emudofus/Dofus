package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyCancelInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cancelerId:uint = 0;
        public var guestId:uint = 0;
        public static const protocolId:uint = 6251;

        public function PartyCancelInvitationNotificationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6251;
        }// end function

        public function initPartyCancelInvitationNotificationMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : PartyCancelInvitationNotificationMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.cancelerId = param2;
            this.guestId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.cancelerId = 0;
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
            this.serializeAs_PartyCancelInvitationNotificationMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyCancelInvitationNotificationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            if (this.cancelerId < 0)
            {
                throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
            }
            param1.writeInt(this.cancelerId);
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
            }
            param1.writeInt(this.guestId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyCancelInvitationNotificationMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyCancelInvitationNotificationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.cancelerId = param1.readInt();
            if (this.cancelerId < 0)
            {
                throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyCancelInvitationNotificationMessage.cancelerId.");
            }
            this.guestId = param1.readInt();
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element of PartyCancelInvitationNotificationMessage.guestId.");
            }
            return;
        }// end function

    }
}
