package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StatsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var statId:uint = 11;
        public var boostPoint:uint = 0;
        public static const protocolId:uint = 5610;

        public function StatsUpgradeRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5610;
        }// end function

        public function initStatsUpgradeRequestMessage(param1:uint = 11, param2:uint = 0) : StatsUpgradeRequestMessage
        {
            this.statId = param1;
            this.boostPoint = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.statId = 11;
            this.boostPoint = 0;
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
            this.serializeAs_StatsUpgradeRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_StatsUpgradeRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.statId);
            if (this.boostPoint < 0)
            {
                throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
            }
            param1.writeShort(this.boostPoint);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StatsUpgradeRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_StatsUpgradeRequestMessage(param1:IDataInput) : void
        {
            this.statId = param1.readByte();
            if (this.statId < 0)
            {
                throw new Error("Forbidden value (" + this.statId + ") on element of StatsUpgradeRequestMessage.statId.");
            }
            this.boostPoint = param1.readShort();
            if (this.boostPoint < 0)
            {
                throw new Error("Forbidden value (" + this.boostPoint + ") on element of StatsUpgradeRequestMessage.boostPoint.");
            }
            return;
        }// end function

    }
}
