package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightHumanReadyStateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;
        public var isReady:Boolean = false;
        public static const protocolId:uint = 740;

        public function GameFightHumanReadyStateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 740;
        }// end function

        public function initGameFightHumanReadyStateMessage(param1:uint = 0, param2:Boolean = false) : GameFightHumanReadyStateMessage
        {
            this.characterId = param1;
            this.isReady = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.characterId = 0;
            this.isReady = false;
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
            this.serializeAs_GameFightHumanReadyStateMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightHumanReadyStateMessage(param1:IDataOutput) : void
        {
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            param1.writeInt(this.characterId);
            param1.writeBoolean(this.isReady);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightHumanReadyStateMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightHumanReadyStateMessage(param1:IDataInput) : void
        {
            this.characterId = param1.readInt();
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element of GameFightHumanReadyStateMessage.characterId.");
            }
            this.isReady = param1.readBoolean();
            return;
        }// end function

    }
}
