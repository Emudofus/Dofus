package com.ankamagames.dofus.scripts
{
    import com.ankamagames.jerakine.script.runners.IRunner;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.misc.ISpellCastProvider;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.sequencer.ISequencable;

    public class SpellFxRunner extends FxRunner implements IRunner 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellFxRunner));

        private var _spellCastProvider:ISpellCastProvider;

        public function SpellFxRunner(spellCastProvider:ISpellCastProvider)
        {
            super(DofusEntities.getEntity(spellCastProvider.castingSpell.casterId), spellCastProvider.castingSpell.targetedCell);
            this._spellCastProvider = spellCastProvider;
        }

        public function get castingSpell():CastingSpell
        {
            return (this._spellCastProvider.castingSpell);
        }

        public function get stepsBuffer():Vector.<ISequencable>
        {
            return (this._spellCastProvider.stepsBuffer);
        }


    }
}//package com.ankamagames.dofus.scripts

