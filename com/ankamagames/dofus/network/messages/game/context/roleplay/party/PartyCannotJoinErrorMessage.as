package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyCannotJoinErrorMessage extends AbstractPartyMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var reason:uint = 0;
        public static const protocolId:uint = 5583;

        public function PartyCannotJoinErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5583;
        }// end function

        public function initPartyCannotJoinErrorMessage(param1:uint = 0, param2:uint = 0) : PartyCannotJoinErrorMessage
        {
            super.initAbstractPartyMessage(param1);
            this.reason = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.reason = 0;
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
            this.serializeAs_PartyCannotJoinErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyCannotJoinErrorMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyMessage(param1);
            param1.writeByte(this.reason);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyCannotJoinErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyCannotJoinErrorMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.reason = param1.readByte();
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element of PartyCannotJoinErrorMessage.reason.");
            }
            return;
        }// end function

    }
}
