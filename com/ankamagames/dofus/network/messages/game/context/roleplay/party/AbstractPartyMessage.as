package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractPartyMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var partyId:uint = 0;
        public static const protocolId:uint = 6274;

        public function AbstractPartyMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6274;
        }// end function

        public function initAbstractPartyMessage(param1:uint = 0) : AbstractPartyMessage
        {
            this.partyId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.partyId = 0;
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AbstractPartyMessage(param1);
            return;
        }// end function

        public function serializeAs_AbstractPartyMessage(param1:IDataOutput) : void
        {
            if (this.partyId < 0)
            {
                throw new Error("Forbidden value (" + this.partyId + ") on element partyId.");
            }
            param1.writeInt(this.partyId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractPartyMessage(param1);
            return;
        }// end function

        public function deserializeAs_AbstractPartyMessage(param1:IDataInput) : void
        {
            this.partyId = param1.readInt();
            if (this.partyId < 0)
            {
                throw new Error("Forbidden value (" + this.partyId + ") on element of AbstractPartyMessage.partyId.");
            }
            return;
        }// end function

    }
}
