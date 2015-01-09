package com.ankamagames.dofus.network.types.game.character.choice
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CharacterToRemodelInformations extends CharacterRemodelingInformation implements INetworkType 
    {

        public static const protocolId:uint = 477;

        public var possibleChangeMask:uint = 0;
        public var mandatoryChangeMask:uint = 0;


        override public function getTypeId():uint
        {
            return (477);
        }

        public function initCharacterToRemodelInformations(id:uint=0, name:String="", breed:int=0, sex:Boolean=false, cosmeticId:uint=0, colors:Vector.<int>=null, possibleChangeMask:uint=0, mandatoryChangeMask:uint=0):CharacterToRemodelInformations
        {
            super.initCharacterRemodelingInformation(id, name, breed, sex, cosmeticId, colors);
            this.possibleChangeMask = possibleChangeMask;
            this.mandatoryChangeMask = mandatoryChangeMask;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.possibleChangeMask = 0;
            this.mandatoryChangeMask = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterToRemodelInformations(output);
        }

        public function serializeAs_CharacterToRemodelInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_CharacterRemodelingInformation(output);
            if (this.possibleChangeMask < 0)
            {
                throw (new Error((("Forbidden value (" + this.possibleChangeMask) + ") on element possibleChangeMask.")));
            };
            output.writeByte(this.possibleChangeMask);
            if (this.mandatoryChangeMask < 0)
            {
                throw (new Error((("Forbidden value (" + this.mandatoryChangeMask) + ") on element mandatoryChangeMask.")));
            };
            output.writeByte(this.mandatoryChangeMask);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterToRemodelInformations(input);
        }

        public function deserializeAs_CharacterToRemodelInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.possibleChangeMask = input.readByte();
            if (this.possibleChangeMask < 0)
            {
                throw (new Error((("Forbidden value (" + this.possibleChangeMask) + ") on element of CharacterToRemodelInformations.possibleChangeMask.")));
            };
            this.mandatoryChangeMask = input.readByte();
            if (this.mandatoryChangeMask < 0)
            {
                throw (new Error((("Forbidden value (" + this.mandatoryChangeMask) + ") on element of CharacterToRemodelInformations.mandatoryChangeMask.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character.choice

