package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterSelectionWithRenameMessage extends CharacterSelectionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public static const protocolId:uint = 6121;

        public function CharacterSelectionWithRenameMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6121;
        }// end function

        public function initCharacterSelectionWithRenameMessage(param1:int = 0, param2:String = "") : CharacterSelectionWithRenameMessage
        {
            super.initCharacterSelectionMessage(param1);
            this.name = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.name = "";
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
            this.serializeAs_CharacterSelectionWithRenameMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterSelectionWithRenameMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterSelectionMessage(param1);
            param1.writeUTF(this.name);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterSelectionWithRenameMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterSelectionWithRenameMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
