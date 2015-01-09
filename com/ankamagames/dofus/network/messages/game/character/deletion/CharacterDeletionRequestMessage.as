package com.ankamagames.dofus.network.messages.game.character.deletion
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterDeletionRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 165;

        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;
        public var secretAnswerHash:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (165);
        }

        public function initCharacterDeletionRequestMessage(characterId:uint=0, secretAnswerHash:String=""):CharacterDeletionRequestMessage
        {
            this.characterId = characterId;
            this.secretAnswerHash = secretAnswerHash;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.characterId = 0;
            this.secretAnswerHash = "";
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterDeletionRequestMessage(output);
        }

        public function serializeAs_CharacterDeletionRequestMessage(output:ICustomDataOutput):void
        {
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element characterId.")));
            };
            output.writeInt(this.characterId);
            output.writeUTF(this.secretAnswerHash);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterDeletionRequestMessage(input);
        }

        public function deserializeAs_CharacterDeletionRequestMessage(input:ICustomDataInput):void
        {
            this.characterId = input.readInt();
            if (this.characterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.characterId) + ") on element of CharacterDeletionRequestMessage.characterId.")));
            };
            this.secretAnswerHash = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.deletion

