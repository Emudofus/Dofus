package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightTurnStartSlaveMessage extends GameFightTurnStartMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var idSummoner:int = 0;
        public static const protocolId:uint = 6213;

        public function GameFightTurnStartSlaveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6213;
        }// end function

        public function initGameFightTurnStartSlaveMessage(param1:int = 0, param2:uint = 0, param3:int = 0) : GameFightTurnStartSlaveMessage
        {
            super.initGameFightTurnStartMessage(param1, param2);
            this.idSummoner = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.idSummoner = 0;
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
            this.serializeAs_GameFightTurnStartSlaveMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightTurnStartSlaveMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightTurnStartMessage(param1);
            param1.writeInt(this.idSummoner);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightTurnStartSlaveMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightTurnStartSlaveMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.idSummoner = param1.readInt();
            return;
        }// end function

    }
}
