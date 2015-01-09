package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class CharacterMinimalInformations extends AbstractCharacterInformation implements INetworkType 
    {

        public static const protocolId:uint = 110;

        public var level:uint = 0;
        public var name:String = "";


        override public function getTypeId():uint
        {
            return (110);
        }

        public function initCharacterMinimalInformations(id:uint=0, level:uint=0, name:String=""):CharacterMinimalInformations
        {
            super.initAbstractCharacterInformation(id);
            this.level = level;
            this.name = name;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.level = 0;
            this.name = "";
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterMinimalInformations(output);
        }

        public function serializeAs_CharacterMinimalInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractCharacterInformation(output);
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
            output.writeUTF(this.name);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterMinimalInformations(input);
        }

        public function deserializeAs_CharacterMinimalInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.level = input.readUnsignedByte();
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of CharacterMinimalInformations.level.")));
            };
            this.name = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.types.game.character

