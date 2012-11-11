package com.ankamagames.dofus.scripts
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.script.runners.*;
    import flash.utils.*;

    public class SpellFxRunner extends FxRunner implements IRunner
    {
        private var _spellCastProvider:ISpellCastProvider;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellFxRunner));

        public function SpellFxRunner(param1:ISpellCastProvider)
        {
            super(DofusEntities.getEntity(param1.castingSpell.casterId), param1.castingSpell.targetedCell);
            this._spellCastProvider = param1;
            return;
        }// end function

        public function get castingSpell() : CastingSpell
        {
            return this._spellCastProvider.castingSpell;
        }// end function

        public function get stepsBuffer() : Vector.<ISequencable>
        {
            return this._spellCastProvider.stepsBuffer;
        }// end function

    }
}
