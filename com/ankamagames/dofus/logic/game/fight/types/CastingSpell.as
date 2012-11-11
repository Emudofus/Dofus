package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.jerakine.types.positions.*;

    public class CastingSpell extends Object
    {
        public var castingSpellId:uint;
        public var casterId:int;
        public var targetedCell:MapPoint;
        public var spell:Spell;
        public var spellRank:SpellLevel;
        public var markId:int;
        public var markType:int;
        public var silentCast:Boolean;
        public var weaponId:int = -1;
        public var isCriticalHit:Boolean;
        public var isCriticalFail:Boolean;
        private static var _unicID:uint = 0;

        public function CastingSpell(param1:Boolean = true)
        {
            if (param1)
            {
                this.castingSpellId = _unicID + 1;
            }
            return;
        }// end function

    }
}
