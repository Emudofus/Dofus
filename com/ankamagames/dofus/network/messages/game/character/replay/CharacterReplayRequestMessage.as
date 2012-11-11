package com.ankamagames.dofus.network.messages.game.character.replay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterReplayRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;
        public static const protocolId:uint = 167;

        public function CharacterReplayRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 167;
        }// end function

        public function initCharacterReplayRequestMessage(param1:uint = 0) : CharacterReplayRequestMessage
        {
            this.characterId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.characterId = 0;
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
            this.serializeAs_CharacterReplayRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterReplayRequestMessage(param1:IDataOutput) : void
        {
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            param1.writeInt(this.characterId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterReplayRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterReplayRequestMessage(param1:IDataInput) : void
        {
            this.characterId = param1.readInt();
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterReplayRequestMessage.characterId.");
            }
            return;
        }// end function

    }
}
