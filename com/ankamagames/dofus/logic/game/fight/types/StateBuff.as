package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostStateEffect;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   
   public class StateBuff extends BasicBuff
   {
      
      public function StateBuff(effect:FightTemporaryBoostStateEffect = null, castingSpell:CastingSpell = null, actionId:uint = 0) {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.stateId,null,null);
            this._statName = ActionIdConverter.getActionStatName(actionId);
            this.stateId = effect.stateId;
         }
      }
      
      protected static const _log:Logger;
      
      private var _statName:String;
      
      public var stateId:int;
      
      override public function get type() : String {
         return "StateBuff";
      }
      
      public function get statName() : String {
         return this._statName;
      }
      
      override public function onApplyed() : void {
         FightersStateManager.getInstance().addStateOnTarget(this.stateId,targetId);
         SpellWrapper.refreshAllPlayerSpellHolder(targetId);
         super.onApplyed();
      }
      
      override public function onRemoved() : void {
         var fbf:FightBattleFrame = null;
         if(!_removed)
         {
            FightersStateManager.getInstance().removeStateOnTarget(this.stateId,targetId);
            SpellWrapper.refreshAllPlayerSpellHolder(targetId);
            fbf = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if((fbf) && (!fbf.executingSequence) && (fbf.deadFightersList.indexOf(targetId) == -1))
            {
               if(actionId == 952)
               {
                  FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_ENTERING_STATE,[targetId,this.stateId],targetId,-1,true);
               }
               else
               {
                  FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_LEAVING_STATE,[targetId,this.stateId],targetId,-1,true);
               }
            }
         }
         super.onRemoved();
      }
      
      override public function clone(id:int = 0) : BasicBuff {
         var sb:StateBuff = new StateBuff();
         sb._statName = this._statName;
         sb.stateId = this.stateId;
         sb.id = uid;
         sb.uid = uid;
         sb.actionId = actionId;
         sb.targetId = targetId;
         sb.castingSpell = castingSpell;
         sb.duration = duration;
         sb.dispelable = dispelable;
         sb.source = source;
         sb.aliveSource = aliveSource;
         sb.parentBoostUid = parentBoostUid;
         sb.initParam(param1,param2,param3);
         return sb;
      }
   }
}
