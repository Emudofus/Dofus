package com.ankamagames.dofus.network.messages.game.context.roleplay.stats
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StatsUpgradeResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var nbCharacBoost:uint = 0;
        public static const protocolId:uint = 5609;

        public function StatsUpgradeResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5609;
        }// end function

        public function initStatsUpgradeResultMessage(param1:uint = 0) : StatsUpgradeResultMessage
        {
            this.nbCharacBoost = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.nbCharacBoost = 0;
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
            this.serializeAs_StatsUpgradeResultMessage(param1);
            return;
        }// end function

        public function serializeAs_StatsUpgradeResultMessage(param1:IDataOutput) : void
        {
            if (this.nbCharacBoost < 0)
            {
                throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element nbCharacBoost.");
            }
            param1.writeShort(this.nbCharacBoost);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StatsUpgradeResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_StatsUpgradeResultMessage(param1:IDataInput) : void
        {
            this.nbCharacBoost = param1.readShort();
            if (this.nbCharacBoost < 0)
            {
                throw new Error("Forbidden value (" + this.nbCharacBoost + ") on element of StatsUpgradeResultMessage.nbCharacBoost.");
            }
            return;
        }// end function

    }
}
