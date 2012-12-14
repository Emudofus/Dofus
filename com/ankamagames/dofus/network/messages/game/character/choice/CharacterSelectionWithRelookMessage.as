package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterSelectionWithRelookMessage extends CharacterSelectionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cosmeticId:uint = 0;
        public static const protocolId:uint = 6353;

        public function CharacterSelectionWithRelookMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6353;
        }// end function

        public function initCharacterSelectionWithRelookMessage(param1:int = 0, param2:uint = 0) : CharacterSelectionWithRelookMessage
        {
            super.initCharacterSelectionMessage(param1);
            this.cosmeticId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.cosmeticId = 0;
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
            this.serializeAs_CharacterSelectionWithRelookMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterSelectionWithRelookMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterSelectionMessage(param1);
            if (this.cosmeticId < 0)
            {
                throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
            }
            param1.writeInt(this.cosmeticId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterSelectionWithRelookMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterSelectionWithRelookMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.cosmeticId = param1.readInt();
            if (this.cosmeticId < 0)
            {
                throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterSelectionWithRelookMessage.cosmeticId.");
            }
            return;
        }// end function

    }
}
