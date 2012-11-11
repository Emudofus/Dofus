package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterCapabilitiesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var guildEmblemSymbolCategories:uint = 0;
        public static const protocolId:uint = 6339;

        public function CharacterCapabilitiesMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6339;
        }// end function

        public function initCharacterCapabilitiesMessage(param1:uint = 0) : CharacterCapabilitiesMessage
        {
            this.guildEmblemSymbolCategories = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.guildEmblemSymbolCategories = 0;
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
            this.serializeAs_CharacterCapabilitiesMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterCapabilitiesMessage(param1:IDataOutput) : void
        {
            if (this.guildEmblemSymbolCategories < 0)
            {
                throw new Error("Forbidden value (" + this.guildEmblemSymbolCategories + ") on element guildEmblemSymbolCategories.");
            }
            param1.writeInt(this.guildEmblemSymbolCategories);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterCapabilitiesMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterCapabilitiesMessage(param1:IDataInput) : void
        {
            this.guildEmblemSymbolCategories = param1.readInt();
            if (this.guildEmblemSymbolCategories < 0)
            {
                throw new Error("Forbidden value (" + this.guildEmblemSymbolCategories + ") on element of CharacterCapabilitiesMessage.guildEmblemSymbolCategories.");
            }
            return;
        }// end function

    }
}
