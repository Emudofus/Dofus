package com.ankamagames.dofus.network.messages.game.character.creation
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterNameSuggestionSuccessMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var suggestion:String = "";
        public static const protocolId:uint = 5544;

        public function CharacterNameSuggestionSuccessMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5544;
        }// end function

        public function initCharacterNameSuggestionSuccessMessage(param1:String = "") : CharacterNameSuggestionSuccessMessage
        {
            this.suggestion = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.suggestion = "";
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
            this.serializeAs_CharacterNameSuggestionSuccessMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterNameSuggestionSuccessMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.suggestion);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterNameSuggestionSuccessMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterNameSuggestionSuccessMessage(param1:IDataInput) : void
        {
            this.suggestion = param1.readUTF();
            return;
        }// end function

    }
}
