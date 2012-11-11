package com.ankamagames.dofus.network.types.game.character
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterMinimalPlusLookAndGradeInformations extends CharacterMinimalPlusLookInformations implements INetworkType
    {
        public var grade:uint = 0;
        public static const protocolId:uint = 193;

        public function CharacterMinimalPlusLookAndGradeInformations()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 193;
        }// end function

        public function initCharacterMinimalPlusLookAndGradeInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:uint = 0) : CharacterMinimalPlusLookAndGradeInformations
        {
            super.initCharacterMinimalPlusLookInformations(param1, param2, param3, param4);
            this.grade = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.grade = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
            return;
        }// end function

        public function serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterMinimalPlusLookInformations(param1);
            if (this.grade < 0)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element grade.");
            }
            param1.writeInt(this.grade);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
            return;
        }// end function

        public function deserializeAs_CharacterMinimalPlusLookAndGradeInformations(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.grade = param1.readInt();
            if (this.grade < 0)
            {
                throw new Error("Forbidden value (" + this.grade + ") on element of CharacterMinimalPlusLookAndGradeInformations.grade.");
            }
            return;
        }// end function

    }
}
