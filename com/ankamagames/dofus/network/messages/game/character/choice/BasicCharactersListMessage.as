package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class BasicCharactersListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6475;

        private var _isInitialized:Boolean = false;
        public var characters:Vector.<CharacterBaseInformations>;

        public function BasicCharactersListMessage()
        {
            this.characters = new Vector.<CharacterBaseInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6475);
        }

        public function initBasicCharactersListMessage(characters:Vector.<CharacterBaseInformations>=null):BasicCharactersListMessage
        {
            this.characters = characters;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.characters = new Vector.<CharacterBaseInformations>();
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
            this.serializeAs_BasicCharactersListMessage(output);
        }

        public function serializeAs_BasicCharactersListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.characters.length);
            var _i1:uint;
            while (_i1 < this.characters.length)
            {
                output.writeShort((this.characters[_i1] as CharacterBaseInformations).getTypeId());
                (this.characters[_i1] as CharacterBaseInformations).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicCharactersListMessage(input);
        }

        public function deserializeAs_BasicCharactersListMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:CharacterBaseInformations;
            var _charactersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _charactersLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(CharacterBaseInformations, _id1);
                _item1.deserialize(input);
                this.characters.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

