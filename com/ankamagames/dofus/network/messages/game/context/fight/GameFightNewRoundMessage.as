package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightNewRoundMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var roundNumber:uint = 0;
        public static const protocolId:uint = 6239;

        public function GameFightNewRoundMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6239;
        }// end function

        public function initGameFightNewRoundMessage(param1:uint = 0) : GameFightNewRoundMessage
        {
            this.roundNumber = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.roundNumber = 0;
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
            this.serializeAs_GameFightNewRoundMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightNewRoundMessage(param1:IDataOutput) : void
        {
            if (this.roundNumber < 0)
            {
                throw new Error("Forbidden value (" + this.roundNumber + ") on element roundNumber.");
            }
            param1.writeInt(this.roundNumber);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightNewRoundMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightNewRoundMessage(param1:IDataInput) : void
        {
            this.roundNumber = param1.readInt();
            if (this.roundNumber < 0)
            {
                throw new Error("Forbidden value (" + this.roundNumber + ") on element of GameFightNewRoundMessage.roundNumber.");
            }
            return;
        }// end function

    }
}
