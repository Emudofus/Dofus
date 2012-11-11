package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightStartingMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightType:uint = 0;
        public static const protocolId:uint = 700;

        public function GameFightStartingMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 700;
        }// end function

        public function initGameFightStartingMessage(param1:uint = 0) : GameFightStartingMessage
        {
            this.fightType = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
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
            this.serializeAs_GameFightStartingMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightStartingMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.fightType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightStartingMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightStartingMessage(param1:IDataInput) : void
        {
            this.fightType = param1.readByte();
            if (this.fightType < 0)
            {
                throw new Error("Forbidden value (" + this.fightType + ") on element of GameFightStartingMessage.fightType.");
            }
            return;
        }// end function

    }
}
