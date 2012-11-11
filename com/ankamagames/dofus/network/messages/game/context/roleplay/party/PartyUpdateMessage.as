package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var memberInformations:PartyMemberInformations;
        public static const protocolId:uint = 5575;

        public function PartyUpdateMessage()
        {
            this.memberInformations = new PartyMemberInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5575;
        }// end function

        public function initPartyUpdateMessage(param1:uint = 0, param2:PartyMemberInformations = null) : PartyUpdateMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.memberInformations = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.memberInformations = new PartyMemberInformations();
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
            this.serializeAs_PartyUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyUpdateMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            param1.writeShort(this.memberInformations.getTypeId());
            this.memberInformations.serialize(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyUpdateMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            this.memberInformations = ProtocolTypeManager.getInstance(PartyMemberInformations, _loc_2);
            this.memberInformations.deserialize(param1);
            return;
        }// end function

    }
}
