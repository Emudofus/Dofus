package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterLevelUpInformationMessage extends CharacterLevelUpMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var id:uint = 0;
        public var relationType:int = 0;
        public static const protocolId:uint = 6076;

        public function CharacterLevelUpInformationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6076;
        }// end function

        public function initCharacterLevelUpInformationMessage(param1:uint = 0, param2:String = "", param3:uint = 0, param4:int = 0) : CharacterLevelUpInformationMessage
        {
            super.initCharacterLevelUpMessage(param1);
            this.name = param2;
            this.id = param3;
            this.relationType = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.name = "";
            this.id = 0;
            this.relationType = 0;
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
            this.serializeAs_CharacterLevelUpInformationMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterLevelUpInformationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterLevelUpMessage(param1);
            param1.writeUTF(this.name);
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            param1.writeByte(this.relationType);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterLevelUpInformationMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterLevelUpInformationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.name = param1.readUTF();
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of CharacterLevelUpInformationMessage.id.");
            }
            this.relationType = param1.readByte();
            return;
        }// end function

    }
}
