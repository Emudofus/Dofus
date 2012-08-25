package com.ankamagames.dofus.network.messages.game.character.choice
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.character.choice.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharactersListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var hasStartupActions:Boolean = false;
        public var characters:Vector.<CharacterBaseInformations>;
        public static const protocolId:uint = 151;

        public function CharactersListMessage()
        {
            this.characters = new Vector.<CharacterBaseInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 151;
        }// end function

        public function initCharactersListMessage(param1:Boolean = false, param2:Vector.<CharacterBaseInformations> = null) : CharactersListMessage
        {
            this.hasStartupActions = param1;
            this.characters = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.hasStartupActions = false;
            this.characters = new Vector.<CharacterBaseInformations>;
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
            this.serializeAs_CharactersListMessage(param1);
            return;
        }// end function

        public function serializeAs_CharactersListMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.hasStartupActions);
            param1.writeShort(this.characters.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.characters.length)
            {
                
                param1.writeShort((this.characters[_loc_2] as CharacterBaseInformations).getTypeId());
                (this.characters[_loc_2] as CharacterBaseInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharactersListMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharactersListMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:CharacterBaseInformations = null;
            this.hasStartupActions = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(CharacterBaseInformations, _loc_4);
                _loc_5.deserialize(param1);
                this.characters.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
