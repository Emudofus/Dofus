package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightLifePointsGainMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var delta:uint = 0;
        public static const protocolId:uint = 6311;

        public function GameActionFightLifePointsGainMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6311;
        }// end function

        public function initGameActionFightLifePointsGainMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:uint = 0) : GameActionFightLifePointsGainMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.targetId = param3;
            this.delta = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.targetId = 0;
            this.delta = 0;
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
            this.serializeAs_GameActionFightLifePointsGainMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightLifePointsGainMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeInt(this.targetId);
            if (this.delta < 0)
            {
                throw new Error("Forbidden value (" + this.delta + ") on element delta.");
            }
            param1.writeShort(this.delta);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightLifePointsGainMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightLifePointsGainMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.targetId = param1.readInt();
            this.delta = param1.readShort();
            if (this.delta < 0)
            {
                throw new Error("Forbidden value (" + this.delta + ") on element of GameActionFightLifePointsGainMessage.delta.");
            }
            return;
        }// end function

    }
}
