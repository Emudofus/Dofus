package com.ankamagames.dofus.logic.game.common.misc
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;

    public interface ISpellCastProvider
    {

        public function ISpellCastProvider();

        function get castingSpell() : CastingSpell;

        function get stepsBuffer() : Vector.<ISequencable>;

    }
}
