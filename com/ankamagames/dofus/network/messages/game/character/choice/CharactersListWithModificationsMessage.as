package com.ankamagames.dofus.network.messages.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRecolorInformation;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRelookInformation;
    import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class CharactersListWithModificationsMessage extends CharactersListMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6120;

        private var _isInitialized:Boolean = false;
        public var charactersToRecolor:Vector.<CharacterToRecolorInformation>;
        public var charactersToRename:Vector.<int>;
        public var unusableCharacters:Vector.<int>;
        public var charactersToRelook:Vector.<CharacterToRelookInformation>;

        public function CharactersListWithModificationsMessage()
        {
            this.charactersToRecolor = new Vector.<CharacterToRecolorInformation>();
            this.charactersToRename = new Vector.<int>();
            this.unusableCharacters = new Vector.<int>();
            this.charactersToRelook = new Vector.<CharacterToRelookInformation>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6120);
        }

        public function initCharactersListWithModificationsMessage(characters:Vector.<CharacterBaseInformations>=null, hasStartupActions:Boolean=false, charactersToRecolor:Vector.<CharacterToRecolorInformation>=null, charactersToRename:Vector.<int>=null, unusableCharacters:Vector.<int>=null, charactersToRelook:Vector.<CharacterToRelookInformation>=null):CharactersListWithModificationsMessage
        {
            super.initCharactersListMessage(characters, hasStartupActions);
            this.charactersToRecolor = charactersToRecolor;
            this.charactersToRename = charactersToRename;
            this.unusableCharacters = unusableCharacters;
            this.charactersToRelook = charactersToRelook;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.charactersToRecolor = new Vector.<CharacterToRecolorInformation>();
            this.charactersToRename = new Vector.<int>();
            this.unusableCharacters = new Vector.<int>();
            this.charactersToRelook = new Vector.<CharacterToRelookInformation>();
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
            this.serializeAs_CharactersListWithModificationsMessage(output);
        }

        public function serializeAs_CharactersListWithModificationsMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_CharactersListMessage(output);
            output.writeShort(this.charactersToRecolor.length);
            var _i1:uint;
            while (_i1 < this.charactersToRecolor.length)
            {
                (this.charactersToRecolor[_i1] as CharacterToRecolorInformation).serializeAs_CharacterToRecolorInformation(output);
                _i1++;
            };
            output.writeShort(this.charactersToRename.length);
            var _i2:uint;
            while (_i2 < this.charactersToRename.length)
            {
                output.writeInt(this.charactersToRename[_i2]);
                _i2++;
            };
            output.writeShort(this.unusableCharacters.length);
            var _i3:uint;
            while (_i3 < this.unusableCharacters.length)
            {
                output.writeInt(this.unusableCharacters[_i3]);
                _i3++;
            };
            output.writeShort(this.charactersToRelook.length);
            var _i4:uint;
            while (_i4 < this.charactersToRelook.length)
            {
                (this.charactersToRelook[_i4] as CharacterToRelookInformation).serializeAs_CharacterToRelookInformation(output);
                _i4++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharactersListWithModificationsMessage(input);
        }

        public function deserializeAs_CharactersListWithModificationsMessage(input:ICustomDataInput):void
        {
            var _item1:CharacterToRecolorInformation;
            var _val2:int;
            var _val3:int;
            var _item4:CharacterToRelookInformation;
            super.deserialize(input);
            var _charactersToRecolorLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _charactersToRecolorLen)
            {
                _item1 = new CharacterToRecolorInformation();
                _item1.deserialize(input);
                this.charactersToRecolor.push(_item1);
                _i1++;
            };
            var _charactersToRenameLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _charactersToRenameLen)
            {
                _val2 = input.readInt();
                this.charactersToRename.push(_val2);
                _i2++;
            };
            var _unusableCharactersLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _unusableCharactersLen)
            {
                _val3 = input.readInt();
                this.unusableCharacters.push(_val3);
                _i3++;
            };
            var _charactersToRelookLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _charactersToRelookLen)
            {
                _item4 = new CharacterToRelookInformation();
                _item4.deserialize(input);
                this.charactersToRelook.push(_item4);
                _i4++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.choice

