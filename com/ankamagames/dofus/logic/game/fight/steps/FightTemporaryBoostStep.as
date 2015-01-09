package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
    import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;

    public class FightTemporaryBoostStep extends AbstractSequencable implements IFightStep 
    {

        private var _fighterId:int;
        private var _statName:String;
        private var _duration:int;
        private var _durationText:String;
        private var _effect:EffectInstance;

        public function FightTemporaryBoostStep(fighterId:int, statName:String, duration:int, durationText:String, effect:EffectInstance)
        {
            this._fighterId = fighterId;
            this._statName = statName;
            this._duration = duration;
            this._durationText = durationText;
            this._effect = effect;
        }

        public function get stepType():String
        {
            return ("temporaryBoost");
        }

        override public function start():void
        {
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_TEMPORARY_BOOSTED, [this._fighterId, this._effect.description, this._effect.duration, this._effect.durationString, this._effect], this._fighterId, castingSpellId, false, 2);
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.steps

