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
      
      public function StateBuff(param1:FightTemporaryBoostStateEffect=null, param2:CastingSpell=null, param3:uint=0) {
         if(param1)
         {
            super(param1,param2,param3,param1.stateId,null,null);
            this._statName = ActionIdConverter.getActionStatName(param3);
            this.stateId = param1.stateId;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StateBuff));
      
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
         var _loc1_:FightBattleFrame = null;
         if(!_removed)
         {
            FightersStateManager.getInstance().removeStateOnTarget(this.stateId,targetId);
            SpellWrapper.refreshAllPlayerSpellHolder(targetId);
            _loc1_ = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if((_loc1_) && (!_loc1_.executingSequence) && _loc1_.deadFightersList.indexOf(targetId) == -1)
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
      
      override public function clone(param1:int=0) : BasicBuff {
         var _loc2_:StateBuff = new StateBuff();
         _loc2_._statName = this._statName;
         _loc2_.stateId = this.stateId;
         _loc2_.id = uid;
         _loc2_.uid = uid;
         _loc2_.actionId = actionId;
         _loc2_.targetId = targetId;
         _loc2_.castingSpell = castingSpell;
         _loc2_.duration = duration;
         _loc2_.dispelable = dispelable;
         _loc2_.source = source;
         _loc2_.aliveSource = aliveSource;
         _loc2_.parentBoostUid = parentBoostUid;
         _loc2_.initParam(param1,param2,param3);
         return _loc2_;
      }
   }
}
