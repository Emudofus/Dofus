package com.ankamagames.dofus.network.messages.game.character.choice
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharactersListWithModificationsMessage extends CharactersListMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var charactersToRecolor:Vector.<CharacterToRecolorInformation>;
        public var charactersToRename:Vector.<int>;
        public var unusableCharacters:Vector.<int>;
        public var charactersToRelook:Vector.<CharacterToRelookInformation>;
        public static const protocolId:uint = 6120;

        public function CharactersListWithModificationsMessage()
        {
            this.charactersToRecolor = new Vector.<CharacterToRecolorInformation>;
            this.charactersToRename = new Vector.<int>;
            this.unusableCharacters = new Vector.<int>;
            this.charactersToRelook = new Vector.<CharacterToRelookInformation>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6120;
        }// end function

        public function initCharactersListWithModificationsMessage(param1:Boolean = false, param2:Vector.<CharacterBaseInformations> = null, param3:Vector.<CharacterToRecolorInformation> = null, param4:Vector.<int> = null, param5:Vector.<int> = null, param6:Vector.<CharacterToRelookInformation> = null) : CharactersListWithModificationsMessage
        {
            super.initCharactersListMessage(param1, param2);
            this.charactersToRecolor = param3;
            this.charactersToRename = param4;
            this.unusableCharacters = param5;
            this.charactersToRelook = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.charactersToRecolor = new Vector.<CharacterToRecolorInformation>;
            this.charactersToRename = new Vector.<int>;
            this.unusableCharacters = new Vector.<int>;
            this.charactersToRelook = new Vector.<CharacterToRelookInformation>;
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
            this.serializeAs_CharactersListWithModificationsMessage(param1);
            return;
        }// end function

        public function serializeAs_CharactersListWithModificationsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharactersListMessage(param1);
            param1.writeShort(this.charactersToRecolor.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.charactersToRecolor.length)
            {
                
                (this.charactersToRecolor[_loc_2] as CharacterToRecolorInformation).serializeAs_CharacterToRecolorInformation(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.charactersToRename.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.charactersToRename.length)
            {
                
                param1.writeInt(this.charactersToRename[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.unusableCharacters.length);
            var _loc_4:* = 0;
            while (_loc_4 < this.unusableCharacters.length)
            {
                
                param1.writeInt(this.unusableCharacters[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            param1.writeShort(this.charactersToRelook.length);
            var _loc_5:* = 0;
            while (_loc_5 < this.charactersToRelook.length)
            {
                
                (this.charactersToRelook[_loc_5] as CharacterToRelookInformation).serializeAs_CharacterToRelookInformation(param1);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharactersListWithModificationsMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharactersListWithModificationsMessage(param1:IDataInput) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_10 = new CharacterToRecolorInformation();
                _loc_10.deserialize(param1);
                this.charactersToRecolor.push(_loc_10);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_11 = param1.readInt();
                this.charactersToRename.push(_loc_11);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_12 = param1.readInt();
                this.unusableCharacters.push(_loc_12);
                _loc_7 = _loc_7 + 1;
            }
            var _loc_8:* = param1.readUnsignedShort();
            var _loc_9:* = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_13 = new CharacterToRelookInformation();
                _loc_13.deserialize(param1);
                this.charactersToRelook.push(_loc_13);
                _loc_9 = _loc_9 + 1;
            }
            return;
        }// end function

    }
}
