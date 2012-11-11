package com.ankamagames.dofus.network.messages.game.character.deletion
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterDeletionRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;
        public var secretAnswerHash:String = "";
        public static const protocolId:uint = 165;

        public function CharacterDeletionRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 165;
        }// end function

        public function initCharacterDeletionRequestMessage(param1:uint = 0, param2:String = "") : CharacterDeletionRequestMessage
        {
            this.characterId = param1;
            this.secretAnswerHash = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.characterId = 0;
            this.secretAnswerHash = "";
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
            this.serializeAs_CharacterDeletionRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterDeletionRequestMessage(param1:IDataOutput) : void
        {
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            param1.writeInt(this.characterId);
            param1.writeUTF(this.secretAnswerHash);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterDeletionRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterDeletionRequestMessage(param1:IDataInput) : void
        {
            this.characterId = param1.readInt();
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterDeletionRequestMessage.characterId.");
            }
            this.secretAnswerHash = param1.readUTF();
            return;
        }// end function

    }
}
