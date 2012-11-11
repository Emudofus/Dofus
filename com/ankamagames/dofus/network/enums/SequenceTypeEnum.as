package com.ankamagames.dofus.network.enums
{

    public class SequenceTypeEnum extends Object
    {
        public static const SEQUENCE_SPELL:int = 1;
        public static const SEQUENCE_WEAPON:int = 2;
        public static const SEQUENCE_GLYPH_TRAP:int = 3;
        public static const SEQUENCE_TRIGGERED:int = 4;
        public static const SEQUENCE_MOVE:int = 5;
        public static const SEQUENCE_CHARACTER_DEATH:int = 6;
        public static const SEQUENCE_TURN_START:int = 7;
        public static const SEQUENCE_TURN_END:int = 8;
        public static const SEQUENCE_FIGHT_START:int = 9;

        public function SequenceTypeEnum()
        {
            return;
        }// end function

    }
}
