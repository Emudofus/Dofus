package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class CharacterMinimalPlusLookAndGradeInformations extends CharacterMinimalPlusLookInformations implements INetworkType 
    {

        public static const protocolId:uint = 193;

        public var grade:uint = 0;


        override public function getTypeId():uint
        {
            return (193);
        }

        public function initCharacterMinimalPlusLookAndGradeInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, grade:uint=0):CharacterMinimalPlusLookAndGradeInformations
        {
            super.initCharacterMinimalPlusLookInformations(id, level, name, entityLook);
            this.grade = grade;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.grade = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_CharacterMinimalPlusLookAndGradeInformations(output);
        }

        public function serializeAs_CharacterMinimalPlusLookAndGradeInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_CharacterMinimalPlusLookInformations(output);
            if (this.grade < 0)
            {
                throw (new Error((("Forbidden value (" + this.grade) + ") on element grade.")));
            };
            output.writeVarInt(this.grade);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CharacterMinimalPlusLookAndGradeInformations(input);
        }

        public function deserializeAs_CharacterMinimalPlusLookAndGradeInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.grade = input.readVarUhInt();
            if (this.grade < 0)
            {
                throw (new Error((("Forbidden value (" + this.grade) + ") on element of CharacterMinimalPlusLookAndGradeInformations.grade.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.character

