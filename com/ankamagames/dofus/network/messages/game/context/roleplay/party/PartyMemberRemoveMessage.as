package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyMemberRemoveMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var leavingPlayerId:uint = 0;
        public static const protocolId:uint = 5579;

        public function PartyMemberRemoveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5579;
        }// end function

        public function initPartyMemberRemoveMessage(param1:uint = 0, param2:uint = 0) : PartyMemberRemoveMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.leavingPlayerId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.leavingPlayerId = 0;
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
            this.serializeAs_PartyMemberRemoveMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyMemberRemoveMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            if (this.leavingPlayerId < 0)
            {
                throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element leavingPlayerId.");
            }
            param1.writeInt(this.leavingPlayerId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyMemberRemoveMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyMemberRemoveMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.leavingPlayerId = param1.readInt();
            if (this.leavingPlayerId < 0)
            {
                throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element of PartyMemberRemoveMessage.leavingPlayerId.");
            }
            return;
        }// end function

    }
}
