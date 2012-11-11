package com.ankamagames.dofus.logic.game.roleplay.types
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class RoleplaySpellCastProvider extends Object implements ISpellCastProvider
    {
        private var _stepsBuffer:Vector.<ISequencable>;
        private var _castingSpell:CastingSpell;

        public function RoleplaySpellCastProvider()
        {
            this._stepsBuffer = new Vector.<ISequencable>;
            this._castingSpell = new CastingSpell();
            return;
        }// end function

        public function get castingSpell() : CastingSpell
        {
            return this._castingSpell;
        }// end function

        public function get stepsBuffer() : Vector.<ISequencable>
        {
            return this._stepsBuffer;
        }// end function

    }
}
