package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;

    public class FightTackledStep extends AbstractSequencable implements IFightStep, ISequencableListener
    {
        private var _fighterId:int;
        private var _animStep:ISequencable;

        public function FightTackledStep(param1:int)
        {
            this._fighterId = param1;
            return;
        }// end function

        public function get stepType() : String
        {
            return "tackled";
        }// end function

        override public function start() : void
        {
            var _loc_1:* = DofusEntities.getEntity(this._fighterId);
            if (!_loc_1)
            {
                _log.warn("Unable to play tackle of an unexisting fighter " + this._fighterId + ".");
                this.stepFinished();
                return;
            }
            this._animStep = new PlayAnimationStep(_loc_1 as TiphonSprite, AnimationEnum.ANIM_TACLE);
            this._animStep.addListener(this);
            this._animStep.start();
            return;
        }// end function

        public function stepFinished() : void
        {
            this._animStep.removeListener(this);
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_GOT_TACKLED, [this._fighterId], 0, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
