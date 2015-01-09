package com.ankamagames.dofus.network.messages.game.character.creation
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterNameSuggestionSuccessMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5544;

        private var _isInitialized:Boolean = false;
        public var suggestion:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5544);
        }

        public function initCharacterNameSuggestionSuccessMessage(suggestion:String=""):CharacterNameSuggestionSuccessMessage
        {
            this.suggestion = suggestion;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.suggestion = "";
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
            this.serializeAs_CharacterNameSuggestionSuccessMessage(output);
        }

        public function serializeAs_CharacterNameSuggestionSuccessMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.suggestion);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterNameSuggestionSuccessMessage(input);
        }

        public function deserializeAs_CharacterNameSuggestionSuccessMessage(input:ICustomDataInput):void
        {
            this.suggestion = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.creation

