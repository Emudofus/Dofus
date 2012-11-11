package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyMemberEjectedMessage extends PartyMemberRemoveMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var kickerId:uint = 0;
        public static const protocolId:uint = 6252;

        public function PartyMemberEjectedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6252;
        }// end function

        public function initPartyMemberEjectedMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : PartyMemberEjectedMessage
        {
            super.initPartyMemberRemoveMessage(param1, param2);
            this.kickerId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.kickerId = 0;
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
            this.serializeAs_PartyMemberEjectedMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyMemberEjectedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_PartyMemberRemoveMessage(param1);
            if (this.kickerId < 0)
            {
                throw new Error("Forbidden value (" + this.kickerId + ") on element kickerId.");
            }
            param1.writeInt(this.kickerId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyMemberEjectedMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyMemberEjectedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.kickerId = param1.readInt();
            if (this.kickerId < 0)
            {
                throw new Error("Forbidden value (" + this.kickerId + ") on element of PartyMemberEjectedMessage.kickerId.");
            }
            return;
        }// end function

    }
}
