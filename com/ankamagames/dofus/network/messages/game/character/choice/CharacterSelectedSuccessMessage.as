package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterSelectedSuccessMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var infos:CharacterBaseInformations;
        public static const protocolId:uint = 153;

        public function CharacterSelectedSuccessMessage()
        {
            this.infos = new CharacterBaseInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 153;
        }// end function

        public function initCharacterSelectedSuccessMessage(param1:CharacterBaseInformations = null) : CharacterSelectedSuccessMessage
        {
            this.infos = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.infos = new CharacterBaseInformations();
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
            this.serializeAs_CharacterSelectedSuccessMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterSelectedSuccessMessage(param1:IDataOutput) : void
        {
            this.infos.serializeAs_CharacterBaseInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterSelectedSuccessMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterSelectedSuccessMessage(param1:IDataInput) : void
        {
            this.infos = new CharacterBaseInformations();
            this.infos.deserialize(param1);
            return;
        }// end function

    }
}
