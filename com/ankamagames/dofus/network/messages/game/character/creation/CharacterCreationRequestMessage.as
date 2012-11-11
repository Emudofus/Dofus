package com.ankamagames.dofus.network.messages.game.character.creation
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterCreationRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var colors:Vector.<int>;
        public static const protocolId:uint = 160;

        public function CharacterCreationRequestMessage()
        {
            this.colors = new Vector.<int>(5, true);
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 160;
        }// end function

        public function initCharacterCreationRequestMessage(param1:String = "", param2:int = 0, param3:Boolean = false, param4:Vector.<int> = null) : CharacterCreationRequestMessage
        {
            this.name = param1;
            this.breed = param2;
            this.sex = param3;
            this.colors = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.name = "";
            this.breed = 0;
            this.sex = false;
            this.colors = new Vector.<int>(5, true);
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
            this.serializeAs_CharacterCreationRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterCreationRequestMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.name);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            var _loc_2:* = 0;
            while (_loc_2 < 5)
            {
                
                param1.writeInt(this.colors[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterCreationRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterCreationRequestMessage(param1:IDataInput) : void
        {
            this.name = param1.readUTF();
            this.breed = param1.readByte();
            if (this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Steamer)
            {
                throw new Error("Forbidden value (" + this.breed + ") on element of CharacterCreationRequestMessage.breed.");
            }
            this.sex = param1.readBoolean();
            var _loc_2:* = 0;
            while (_loc_2 < 5)
            {
                
                this.colors[_loc_2] = param1.readInt();
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

    }
}
