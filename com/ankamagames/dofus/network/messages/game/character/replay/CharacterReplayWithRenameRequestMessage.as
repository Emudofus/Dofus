package com.ankamagames.dofus.network.messages.game.character.replay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterReplayWithRenameRequestMessage extends CharacterReplayRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public static const protocolId:uint = 6122;

        public function CharacterReplayWithRenameRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6122;
        }// end function

        public function initCharacterReplayWithRenameRequestMessage(param1:uint = 0, param2:String = "") : CharacterReplayWithRenameRequestMessage
        {
            super.initCharacterReplayRequestMessage(param1);
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
            this.serializeAs_CharacterReplayWithRenameRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterReplayWithRenameRequestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterReplayRequestMessage(param1);
            param1.writeUTF(this.name);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterReplayWithRenameRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterReplayWithRenameRequestMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
