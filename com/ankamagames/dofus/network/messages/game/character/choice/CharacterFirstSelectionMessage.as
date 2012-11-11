package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterFirstSelectionMessage extends CharacterSelectionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var doTutorial:Boolean = false;
        public static const protocolId:uint = 6084;

        public function CharacterFirstSelectionMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6084;
        }// end function

        public function initCharacterFirstSelectionMessage(param1:int = 0, param2:Boolean = false) : CharacterFirstSelectionMessage
        {
            super.initCharacterSelectionMessage(param1);
            this.doTutorial = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.doTutorial = false;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterFirstSelectionMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterFirstSelectionMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterSelectionMessage(param1);
            param1.writeBoolean(this.doTutorial);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterFirstSelectionMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterFirstSelectionMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.doTutorial = param1.readBoolean();
            return;
        }// end function

    }
}
