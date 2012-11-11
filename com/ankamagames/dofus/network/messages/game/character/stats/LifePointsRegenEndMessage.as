package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LifePointsRegenEndMessage extends UpdateLifePointsMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var lifePointsGained:uint = 0;
        public static const protocolId:uint = 5686;

        public function LifePointsRegenEndMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5686;
        }// end function

        public function initLifePointsRegenEndMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : LifePointsRegenEndMessage
        {
            super.initUpdateLifePointsMessage(param1, param2);
            this.lifePointsGained = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.lifePointsGained = 0;
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
            this.serializeAs_LifePointsRegenEndMessage(param1);
            return;
        }// end function

        public function serializeAs_LifePointsRegenEndMessage(param1:IDataOutput) : void
        {
            super.serializeAs_UpdateLifePointsMessage(param1);
            if (this.lifePointsGained < 0)
            {
                throw new Error("Forbidden value (" + this.lifePointsGained + ") on element lifePointsGained.");
            }
            param1.writeInt(this.lifePointsGained);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LifePointsRegenEndMessage(param1);
            return;
        }// end function

        public function deserializeAs_LifePointsRegenEndMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.lifePointsGained = param1.readInt();
            if (this.lifePointsGained < 0)
            {
                throw new Error("Forbidden value (" + this.lifePointsGained + ") on element of LifePointsRegenEndMessage.lifePointsGained.");
            }
            return;
        }// end function

    }
}
