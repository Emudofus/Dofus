package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightTurnStartMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:int = 0;
        public var waitTime:uint = 0;
        public static const protocolId:uint = 714;

        public function GameFightTurnStartMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 714;
        }// end function

        public function initGameFightTurnStartMessage(param1:int = 0, param2:uint = 0) : GameFightTurnStartMessage
        {
            this.id = param1;
            this.waitTime = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
            this.waitTime = 0;
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
            this.serializeAs_GameFightTurnStartMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightTurnStartMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.id);
            if (this.waitTime < 0)
            {
                throw new Error("Forbidden value (" + this.waitTime + ") on element waitTime.");
            }
            param1.writeInt(this.waitTime);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightTurnStartMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightTurnStartMessage(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            this.waitTime = param1.readInt();
            if (this.waitTime < 0)
            {
                throw new Error("Forbidden value (" + this.waitTime + ") on element of GameFightTurnStartMessage.waitTime.");
            }
            return;
        }// end function

    }
}
