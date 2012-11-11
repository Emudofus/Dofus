package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyLeaderUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var partyLeaderId:uint = 0;
        public static const protocolId:uint = 5578;

        public function PartyLeaderUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5578;
        }// end function

        public function initPartyLeaderUpdateMessage(param1:uint = 0, param2:uint = 0) : PartyLeaderUpdateMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.partyLeaderId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.partyLeaderId = 0;
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
            this.serializeAs_PartyLeaderUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyLeaderUpdateMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            if (this.partyLeaderId < 0)
            {
                throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
            }
            param1.writeInt(this.partyLeaderId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyLeaderUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyLeaderUpdateMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.partyLeaderId = param1.readInt();
            if (this.partyLeaderId < 0)
            {
                throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyLeaderUpdateMessage.partyLeaderId.");
            }
            return;
        }// end function

    }
}
