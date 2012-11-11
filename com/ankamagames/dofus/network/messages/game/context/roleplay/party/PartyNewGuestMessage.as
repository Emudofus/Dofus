package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyNewGuestMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guest:PartyGuestInformations;
        public static const protocolId:uint = 6260;

        public function PartyNewGuestMessage()
        {
            this.guest = new PartyGuestInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6260;
        }// end function

        public function initPartyNewGuestMessage(param1:uint = 0, param2:PartyGuestInformations = null) : PartyNewGuestMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.guest = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.guest = new PartyGuestInformations();
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
            this.serializeAs_PartyNewGuestMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyNewGuestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            this.guest.serializeAs_PartyGuestInformations(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyNewGuestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyNewGuestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.guest = new PartyGuestInformations();
            this.guest.deserialize(param1);
            return;
        }// end function

    }
}
