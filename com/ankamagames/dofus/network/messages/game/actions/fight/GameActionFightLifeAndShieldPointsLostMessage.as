package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightLifeAndShieldPointsLostMessage extends GameActionFightLifePointsLostMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var shieldLoss:uint = 0;
        public static const protocolId:uint = 6310;

        public function GameActionFightLifeAndShieldPointsLostMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6310;
        }// end function

        public function initGameActionFightLifeAndShieldPointsLostMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : GameActionFightLifeAndShieldPointsLostMessage
        {
            super.initGameActionFightLifePointsLostMessage(param1, param2, param3, param4, param5);
            this.shieldLoss = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.shieldLoss = 0;
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
            this.serializeAs_GameActionFightLifeAndShieldPointsLostMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightLifeAndShieldPointsLostMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GameActionFightLifePointsLostMessage(param1);
            if (this.shieldLoss < 0)
            {
                throw new Error("Forbidden value (" + this.shieldLoss + ") on element shieldLoss.");
            }
            param1.writeShort(this.shieldLoss);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightLifeAndShieldPointsLostMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightLifeAndShieldPointsLostMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.shieldLoss = param1.readShort();
            if (this.shieldLoss < 0)
            {
                throw new Error("Forbidden value (" + this.shieldLoss + ") on element of GameActionFightLifeAndShieldPointsLostMessage.shieldLoss.");
            }
            return;
        }// end function

    }
}
