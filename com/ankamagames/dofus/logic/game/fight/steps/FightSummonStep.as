package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.display.Sprite;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   
   public class FightSummonStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightSummonStep(summonerId:int, summonInfos:GameFightFighterInformations) {
         super();
         this._summonerId = summonerId;
         this._summonInfos = summonInfos;
      }
      
      private var _summonerId:int;
      
      private var _summonInfos:GameFightFighterInformations;
      
      public function get stepType() : String {
         return "summon";
      }
      
      override public function start() : void {
         var fighterInfos:GameFightFighterInformations = null;
         var summonedCreature:Sprite = DofusEntities.getEntity(this._summonInfos.contextualId) as Sprite;
         if(summonedCreature)
         {
            summonedCreature.visible = true;
         }
         SpellWrapper.refreshAllPlayerSpellHolder(this._summonerId);
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if((fightBattleFrame) && (!(fightBattleFrame.deadFightersList.indexOf(this._summonInfos.contextualId) == -1)))
         {
            fightBattleFrame.deadFightersList.splice(fightBattleFrame.deadFightersList.indexOf(this._summonInfos.contextualId),1);
         }
         if(this._summonInfos.contextualId == PlayedCharacterManager.getInstance().id)
         {
            fighterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._summonInfos.contextualId) as GameFightFighterInformations;
            if(!fighterInfos)
            {
               super.executeCallbacks();
               return;
            }
            CurrentPlayedFighterManager.getInstance().getSpellCastManager().resetInitialCooldown(true);
            fighterInfos.stats.lifePoints = this._summonInfos.stats.lifePoints;
            if(PlayedCharacterManager.getInstance().id == this._summonInfos.contextualId)
            {
               PlayedCharacterManager.getInstance().characteristics.lifePoints = fighterInfos.stats.lifePoints;
            }
         }
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_SUMMONED,[this._summonerId,this._summonInfos.contextualId],this._summonInfos.contextualId,castingSpellId);
         executeCallbacks();
      }
   }
}
