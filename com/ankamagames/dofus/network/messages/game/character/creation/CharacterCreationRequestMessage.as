package com.ankamagames.dofus.network.messages.game.character.creation
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
    import __AS3__.vec.*;

    [Trusted]
    public class CharacterCreationRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 160;

        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var breed:int = 0;
        public var sex:Boolean = false;
        public var colors:Vector.<int>;
        public var cosmeticId:uint = 0;

        public function CharacterCreationRequestMessage()
        {
            this.colors = new Vector.<int>(5, true);
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (160);
        }

        public function initCharacterCreationRequestMessage(name:String="", breed:int=0, sex:Boolean=false, colors:Vector.<int>=null, cosmeticId:uint=0):CharacterCreationRequestMessage
        {
            this.name = name;
            this.breed = breed;
            this.sex = sex;
            this.colors = colors;
            this.cosmeticId = cosmeticId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.name = "";
            this.breed = 0;
            this.sex = false;
            this.colors = new Vector.<int>(5, true);
            this.cosmeticId = 0;
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
            this.serializeAs_CharacterCreationRequestMessage(output);
        }

        public function serializeAs_CharacterCreationRequestMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.name);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            var _i4:uint;
            while (_i4 < 5)
            {
                output.writeInt(this.colors[_i4]);
                _i4++;
            };
            if (this.cosmeticId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cosmeticId) + ") on element cosmeticId.")));
            };
            output.writeVarShort(this.cosmeticId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterCreationRequestMessage(input);
        }

        public function deserializeAs_CharacterCreationRequestMessage(input:ICustomDataInput):void
        {
            this.name = input.readUTF();
            this.breed = input.readByte();
            if ((((this.breed < PlayableBreedEnum.Feca)) || ((this.breed > PlayableBreedEnum.Eliatrope))))
            {
                throw (new Error((("Forbidden value (" + this.breed) + ") on element of CharacterCreationRequestMessage.breed.")));
            };
            this.sex = input.readBoolean();
            var _i4:uint;
            while (_i4 < 5)
            {
                this.colors[_i4] = input.readInt();
                _i4++;
            };
            this.cosmeticId = input.readVarUhShort();
            if (this.cosmeticId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cosmeticId) + ") on element of CharacterCreationRequestMessage.cosmeticId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.creation

