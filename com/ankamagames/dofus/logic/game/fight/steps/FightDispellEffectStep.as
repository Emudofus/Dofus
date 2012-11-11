package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.jerakine.sequencer.*;

    public class FightDispellEffectStep extends AbstractSequencable implements IFightStep
    {
        private var _fighterId:int;
        private var _boostUID:int;

        public function FightDispellEffectStep(param1:int, param2:int)
        {
            this._fighterId = param1;
            this._boostUID = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "dispellEffect";
        }// end function

        override public function start() : void
        {
            BuffManager.getInstance().dispellUniqueBuff(this._fighterId, this._boostUID, true, false, true);
            executeCallbacks();
            return;
        }// end function

    }
}
