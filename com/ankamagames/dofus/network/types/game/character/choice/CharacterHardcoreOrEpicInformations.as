package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class CharacterHardcoreOrEpicInformations extends CharacterBaseInformations implements INetworkType 
    {

        public static const protocolId:uint = 474;

        public var deathState:uint = 0;
        public var deathCount:uint = 0;
        public var deathMaxLevel:uint = 0;


        override public function getTypeId():uint
        {
            return (474);
        }

        public function initCharacterHardcoreOrEpicInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, breed:int=0, sex:Boolean=false, deathState:uint=0, deathCount:uint=0, deathMaxLevel:uint=0):CharacterHardcoreOrEpicInformations
        {
            super.initCharacterBaseInformations(id, level, name, entityLook, breed, sex);
            this.deathState = deathState;
            this.deathCount = deathCount;
            this.deathMaxLevel = deathMaxLevel;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.deathState = 0;
            this.deathCount = 0;
            this.deathMaxLevel = 0;
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_CharacterHardcoreOrEpicInformations(output);
        }

        public function serializeAs_CharacterHardcoreOrEpicInformations(output:IDataOutput):void
        {
            super.serializeAs_CharacterBaseInformations(output);
            output.writeByte(this.deathState);
            if (this.deathCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.deathCount) + ") on element deathCount.")));
            };
            output.writeShort(this.deathCount);
            if ((((this.deathMaxLevel < 1)) || ((this.deathMaxLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.deathMaxLevel) + ") on element deathMaxLevel.")));
            };
            output.writeByte(this.deathMaxLevel);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_CharacterHardcoreOrEpicInformations(input);
        }

        public function deserializeAs_CharacterHardcoreOrEpicInformations(input:IDataInput):void
        {
            super.deserialize(input);
            this.deathState = input.readByte();
            if (this.deathState < 0)
            {
                throw (new Error((("Forbidden value (" + this.deathState) + ") on element of CharacterHardcoreOrEpicInformations.deathState.")));
            };
            this.deathCount = input.readShort();
            if (this.deathCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.deathCount) + ") on element of CharacterHardcoreOrEpicInformations.deathCount.")));
            };
            this.deathMaxLevel = input.readUnsignedByte();
            if ((((this.deathMaxLevel < 1)) || ((this.deathMaxLevel > 200))))
            {
                throw (new Error((("Forbidden value (" + this.deathMaxLevel) + ") on element of CharacterHardcoreOrEpicInformations.deathMaxLevel.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.choice

