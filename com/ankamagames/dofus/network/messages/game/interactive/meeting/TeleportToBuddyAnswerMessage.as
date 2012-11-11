package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TeleportToBuddyAnswerMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var buddyId:uint = 0;
        public var accept:Boolean = false;
        public static const protocolId:uint = 6293;

        public function TeleportToBuddyAnswerMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6293;
        }// end function

        public function initTeleportToBuddyAnswerMessage(param1:uint = 0, param2:uint = 0, param3:Boolean = false) : TeleportToBuddyAnswerMessage
        {
            this.dungeonId = param1;
            this.buddyId = param2;
            this.accept = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.buddyId = 0;
            this.accept = false;
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
            this.serializeAs_TeleportToBuddyAnswerMessage(param1);
            return;
        }// end function

        public function serializeAs_TeleportToBuddyAnswerMessage(param1:IDataOutput) : void
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
            param1.writeBoolean(this.accept);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TeleportToBuddyAnswerMessage(param1);
            return;
        }// end function

        public function deserializeAs_TeleportToBuddyAnswerMessage(param1:IDataInput) : void
        {
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyAnswerMessage.dungeonId.");
            }
            this.buddyId = param1.readInt();
            if (this.buddyId < 0)
            {
                throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyAnswerMessage.buddyId.");
            }
            this.accept = param1.readBoolean();
            return;
        }// end function

    }
}
