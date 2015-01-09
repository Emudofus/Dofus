package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterCapabilitiesMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6339;

        private var _isInitialized:Boolean = false;
        public var guildEmblemSymbolCategories:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6339);
        }

        public function initCharacterCapabilitiesMessage(guildEmblemSymbolCategories:uint=0):CharacterCapabilitiesMessage
        {
            this.guildEmblemSymbolCategories = guildEmblemSymbolCategories;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildEmblemSymbolCategories = 0;
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
            this.serializeAs_CharacterCapabilitiesMessage(output);
        }

        public function serializeAs_CharacterCapabilitiesMessage(output:ICustomDataOutput):void
        {
            if (this.guildEmblemSymbolCategories < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildEmblemSymbolCategories) + ") on element guildEmblemSymbolCategories.")));
            };
            output.writeVarInt(this.guildEmblemSymbolCategories);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterCapabilitiesMessage(input);
        }

        public function deserializeAs_CharacterCapabilitiesMessage(input:ICustomDataInput):void
        {
            this.guildEmblemSymbolCategories = input.readVarUhInt();
            if (this.guildEmblemSymbolCategories < 0)
            {
                throw (new Error((("Forbidden value (" + this.guildEmblemSymbolCategories) + ") on element of CharacterCapabilitiesMessage.guildEmblemSymbolCategories.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.initialization

