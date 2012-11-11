package com.ankamagames.dofus.datacenter.spells
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class SpellBomb extends Object implements IDataCenter
    {
        public var id:int;
        public var chainReactionSpellId:int;
        public var explodSpellId:int;
        public var wallId:int;
        public var instantSpellId:int;
        public var comboCoeff:int;
        private static const MODULE:String = "SpellBombs";

        public function SpellBomb()
        {
            return;
        }// end function

        public static function getSpellBombById(param1:int) : SpellBomb
        {
            return GameData.getObject(MODULE, param1) as SpellBomb;
        }// end function

    }
}
