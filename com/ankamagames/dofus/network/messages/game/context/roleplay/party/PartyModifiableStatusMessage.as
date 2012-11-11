package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyModifiableStatusMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var enabled:Boolean = false;
        public static const protocolId:uint = 6277;

        public function PartyModifiableStatusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6277;
        }// end function

        public function initPartyModifiableStatusMessage(param1:uint = 0, param2:Boolean = false) : PartyModifiableStatusMessage
        {
            super.initAbstractPartyMessage(param1);
            this.enabled = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.enabled = false;
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
            this.serializeAs_PartyModifiableStatusMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyModifiableStatusMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            param1.writeBoolean(this.enabled);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyModifiableStatusMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyModifiableStatusMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.enabled = param1.readBoolean();
            return;
        }// end function

    }
}
