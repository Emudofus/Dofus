package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterSelectedErrorMissingMapPackMessage extends CharacterSelectedErrorMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 6300;

        public function CharacterSelectedErrorMissingMapPackMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6300;
        }// end function

        public function initCharacterSelectedErrorMissingMapPackMessage(param1:uint = 0) : CharacterSelectedErrorMissingMapPackMessage
        {
            this.subAreaId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.subAreaId = 0;
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
            this.serializeAs_CharacterSelectedErrorMissingMapPackMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterSelectedErrorMissingMapPackMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterSelectedErrorMessage(param1);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeInt(this.subAreaId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterSelectedErrorMissingMapPackMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterSelectedErrorMissingMapPackMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.subAreaId = param1.readInt();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of CharacterSelectedErrorMissingMapPackMessage.subAreaId.");
            }
            return;
        }// end function

    }
}
