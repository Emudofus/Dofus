package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TeleportToBuddyOfferMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var buddyId:uint = 0;
        public var timeLeft:uint = 0;
        public static const protocolId:uint = 6287;

        public function TeleportToBuddyOfferMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6287;
        }// end function

        public function initTeleportToBuddyOfferMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : TeleportToBuddyOfferMessage
        {
            this.dungeonId = param1;
            this.buddyId = param2;
            this.timeLeft = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.buddyId = 0;
            this.timeLeft = 0;
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
            this.serializeAs_TeleportToBuddyOfferMessage(param1);
            return;
        }// end function

        public function serializeAs_TeleportToBuddyOfferMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            if (this.buddyId < 0)
            {
                throw new Error("Forbidden value (" + this.buddyId + ") on element buddyId.");
            }
            param1.writeInt(this.buddyId);
            if (this.timeLeft < 0)
            {
                throw new Error("Forbidden value (" + this.timeLeft + ") on element timeLeft.");
            }
            param1.writeInt(this.timeLeft);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TeleportToBuddyOfferMessage(param1);
            return;
        }// end function

        public function deserializeAs_TeleportToBuddyOfferMessage(param1:IDataInput) : void
        {
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyOfferMessage.dungeonId.");
            }
            this.buddyId = param1.readInt();
            if (this.buddyId < 0)
            {
                throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyOfferMessage.buddyId.");
            }
            this.timeLeft = param1.readInt();
            if (this.timeLeft < 0)
            {
                throw new Error("Forbidden value (" + this.timeLeft + ") on element of TeleportToBuddyOfferMessage.timeLeft.");
            }
            return;
        }// end function

    }
}
