package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyCancelInvitationMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guestId:uint = 0;
        public static const protocolId:uint = 6254;

        public function PartyCancelInvitationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6254;
        }// end function

        public function initPartyCancelInvitationMessage(param1:uint = 0, param2:uint = 0) : PartyCancelInvitationMessage
        {
            super.initAbstractPartyMessage(param1);
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
            this.serializeAs_PartyCancelInvitationMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyCancelInvitationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
            }
            param1.writeInt(this.guestId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyCancelInvitationMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyCancelInvitationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guestId = param1.readInt();
            if (this.guestId < 0)
            {
                throw new Error("Forbidden value (" + this.guestId + ") on element of PartyCancelInvitationMessage.guestId.");
            }
            return;
        }// end function

    }
}
