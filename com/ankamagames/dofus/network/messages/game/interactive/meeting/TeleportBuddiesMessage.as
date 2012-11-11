package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TeleportBuddiesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public static const protocolId:uint = 6289;

        public function TeleportBuddiesMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6289;
        }// end function

        public function initTeleportBuddiesMessage(param1:uint = 0) : TeleportBuddiesMessage
        {
            this.dungeonId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
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
            this.serializeAs_TeleportBuddiesMessage(param1);
            return;
        }// end function

        public function serializeAs_TeleportBuddiesMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TeleportBuddiesMessage(param1);
            return;
        }// end function

        public function deserializeAs_TeleportBuddiesMessage(param1:IDataInput) : void
        {
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesMessage.dungeonId.");
            }
            return;
        }// end function

    }
}
