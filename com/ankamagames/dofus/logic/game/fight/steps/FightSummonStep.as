package com.ankamagames.dofus.logic.game.fight.steps
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.fightEvents.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.sequencer.*;
    import flash.display.*;

    public class FightSummonStep extends AbstractSequencable implements IFightStep
    {
        private var _summonerId:int;
        private var _summonInfos:GameFightFighterInformations;

        public function FightSummonStep(param1:int, param2:GameFightFighterInformations)
        {
            this._summonerId = param1;
            this._summonInfos = param2;
            return;
        }// end function

        public function get stepType() : String
        {
            return "summon";
        }// end function

        override public function start() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = DofusEntities.getEntity(this._summonInfos.contextualId) as Sprite;
            _loc_1.visible = true;
            SpellWrapper.refreshAllPlayerSpellHolder(this._summonerId);
            var _loc_2:* = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if (_loc_2 && _loc_2.deadFightersList.indexOf(this._summonInfos.contextualId) != -1)
            {
                _loc_2.deadFightersList.splice(_loc_2.deadFightersList.indexOf(this._summonInfos.contextualId), 1);
            }
            if (this._summonInfos.contextualId == PlayedCharacterManager.getInstance().infos.id)
            {
                _loc_3 = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._summonInfos.contextualId) as GameFightFighterInformations;
                if (!_loc_3)
                {
                    super.executeCallbacks();
                    return;
                }
                CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown();
                _loc_3.stats.lifePoints = this._summonInfos.stats.lifePoints;
                if (PlayedCharacterManager.getInstance().infos.id == this._summonInfos.contextualId)
                {
                    PlayedCharacterManager.getInstance().characteristics.lifePoints = _loc_3.stats.lifePoints;
                }
            }
            FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SUMMONED, [this._summonerId, this._summonInfos.contextualId], this._summonInfos.contextualId, castingSpellId);
            executeCallbacks();
            return;
        }// end function

    }
}
