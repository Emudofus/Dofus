package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectUseOnCharacterMessage extends ObjectUseMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var characterId:uint = 0;
        public static const protocolId:uint = 3003;

        public function ObjectUseOnCharacterMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3003;
        }// end function

        public function initObjectUseOnCharacterMessage(param1:uint = 0, param2:uint = 0) : ObjectUseOnCharacterMessage
        {
            super.initObjectUseMessage(param1);
            this.characterId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.characterId = 0;
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
            this.serializeAs_ObjectUseOnCharacterMessage(param1);
            return;
        }// end function

        public function serializeAs_ObjectUseOnCharacterMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectUseMessage(param1);
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            param1.writeInt(this.characterId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectUseOnCharacterMessage(param1);
            return;
        }// end function

        public function deserializeAs_ObjectUseOnCharacterMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.characterId = param1.readInt();
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element of ObjectUseOnCharacterMessage.characterId.");
            }
            return;
        }// end function

    }
}
