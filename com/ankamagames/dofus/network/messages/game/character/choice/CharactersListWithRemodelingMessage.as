package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRemodelInformations;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class CharactersListWithRemodelingMessage extends CharactersListMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6550;

        private var _isInitialized:Boolean = false;
        public var charactersToRemodel:Vector.<CharacterToRemodelInformations>;

        public function CharactersListWithRemodelingMessage()
        {
            this.charactersToRemodel = new Vector.<CharacterToRemodelInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6550);
        }

        public function initCharactersListWithRemodelingMessage(characters:Vector.<CharacterBaseInformations>=null, hasStartupActions:Boolean=false, charactersToRemodel:Vector.<CharacterToRemodelInformations>=null):CharactersListWithRemodelingMessage
        {
            super.initCharactersListMessage(characters, hasStartupActions);
            this.charactersToRemodel = charactersToRemodel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.charactersToRemodel = new Vector.<CharacterToRemodelInformations>();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharactersListWithRemodelingMessage(output);
        }

        public function serializeAs_CharactersListWithRemodelingMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_CharactersListMessage(output);
            output.writeShort(this.charactersToRemodel.length);
            var _i1:uint;
            while (_i1 < this.charactersToRemodel.length)
            {
                (this.charactersToRemodel[_i1] as CharacterToRemodelInformations).serializeAs_CharacterToRemodelInformations(output);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharactersListWithRemodelingMessage(input);
        }

        public function deserializeAs_CharactersListWithRemodelingMessage(input:ICustomDataInput):void
        {
            var _item1:CharacterToRemodelInformations;
            super.deserialize(input);
            var _charactersToRemodelLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _charactersToRemodelLen)
            {
                _item1 = new CharacterToRemodelInformations();
                _item1.deserialize(input);
                this.charactersToRemodel.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

