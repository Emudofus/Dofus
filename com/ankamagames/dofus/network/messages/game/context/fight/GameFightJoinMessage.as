package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class GameFightJoinMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var canBeCancelled:Boolean = false;
        public var canSayReady:Boolean = false;
        public var isSpectator:Boolean = false;
        public var isFightStarted:Boolean = false;
        public var timeMaxBeforeFightStart:uint = 0;
        public var fightType:uint = 0;
        public static const protocolId:uint = 702;

        public function GameFightJoinMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 702;
        }// end function

        public function initGameFightJoinMessage(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:uint = 0, param6:uint = 0) : GameFightJoinMessage
        {
            this.canBeCancelled = param1;
            this.canSayReady = param2;
            this.isSpectator = param3;
            this.isFightStarted = param4;
            this.timeMaxBeforeFightStart = param5;
            this.fightType = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.canBeCancelled = false;
            this.canSayReady = false;
            this.isSpectator = false;
            this.isFightStarted = false;
            this.timeMaxBeforeFightStart = 0;
            this.fightType = 0;
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
            this.serializeAs_GameFightJoinMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightJoinMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.canBeCancelled);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.canSayReady);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 2, this.isSpectator);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 3, this.isFightStarted);
            param1.writeByte(_loc_2);
            if (this.timeMaxBeforeFightStart < 0)
            {
                throw new Error("Forbidden value (" + this.timeMaxBeforeFightStart + ") on element timeMaxBeforeFightStart.");
            }
            param1.writeInt(this.timeMaxBeforeFightStart);
            param1.writeByte(this.fightType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightJoinMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightJoinMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.canBeCancelled = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.canSayReady = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.isSpectator = BooleanByteWrapper.getFlag(_loc_2, 2);
            this.isFightStarted = BooleanByteWrapper.getFlag(_loc_2, 3);
            this.timeMaxBeforeFightStart = param1.readInt();
            if (this.timeMaxBeforeFightStart < 0)
            {
                throw new Error("Forbidden value (" + this.timeMaxBeforeFightStart + ") on element of GameFightJoinMessage.timeMaxBeforeFightStart.");
            }
            this.fightType = param1.readByte();
            if (this.fightType < 0)
            {
                throw new Error("Forbidden value (" + this.fightType + ") on element of GameFightJoinMessage.fightType.");
            }
            return;
        }// end function

    }
}
