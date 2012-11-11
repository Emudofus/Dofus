package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationCancelledForGuestMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cancelerId:uint = 0;
        public static const protocolId:uint = 6256;

        public function PartyInvitationCancelledForGuestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6256;
        }// end function

        public function initPartyInvitationCancelledForGuestMessage(param1:uint = 0, param2:uint = 0) : PartyInvitationCancelledForGuestMessage
        {
            super.initAbstractPartyMessage(param1);
            this.cancelerId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.cancelerId = 0;
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
            this.serializeAs_PartyInvitationCancelledForGuestMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationCancelledForGuestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            if (this.cancelerId < 0)
            {
                throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
            }
            param1.writeInt(this.cancelerId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationCancelledForGuestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationCancelledForGuestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.cancelerId = param1.readInt();
            if (this.cancelerId < 0)
            {
                throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyInvitationCancelledForGuestMessage.cancelerId.");
            }
            return;
        }// end function

    }
}
