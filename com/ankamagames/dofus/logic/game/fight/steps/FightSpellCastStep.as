package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.types.FightEventEnum;
   import com.ankamagames.dofus.network.enums.FightSpellCastCriticalEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   
   public class FightSpellCastStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightSpellCastStep(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint) {
         super();
         this._fighterId = param1;
         this._cellId = param2;
         this._sourceCellId = param3;
         this._spellId = param4;
         this._spellRank = param5;
         this._critical = param6;
      }
      
      private var _fighterId:int;
      
      private var _cellId:int;
      
      private var _sourceCellId:int;
      
      private var _spellId:int;
      
      private var _spellRank:uint;
      
      private var _critical:uint;
      
      public function get stepType() : String {
         return "spellCast";
      }
      
      override public function start() : void {
         var _loc1_:GameFightFighterInformations = null;
         var _loc2_:SerialSequencer = null;
         var _loc3_:ChatBubble = null;
         var _loc4_:IDisplayable = null;
         FightEventsHelper.sendFightEvent(FightEventEnum.FIGHTER_CASTED_SPELL,[this._fighterId,this._cellId,this._sourceCellId,this._spellId,this._spellRank,this._critical],0,castingSpellId,false);
         if(this._critical != FightSpellCastCriticalEnum.NORMAL)
         {
            _loc1_ = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._fighterId) as GameFightFighterInformations;
            _loc2_ = new SerialSequencer();
            if(this._critical == FightSpellCastCriticalEnum.CRITICAL_HIT)
            {
               _loc2_.addStep(new AddGfxEntityStep(1062,_loc1_.disposition.cellId));
            }
            else
            {
               if(this._critical == FightSpellCastCriticalEnum.CRITICAL_FAIL)
               {
                  _loc3_ = new ChatBubble(I18n.getUiText("ui.fight.criticalMiss"));
                  _loc4_ = DofusEntities.getEntity(this._fighterId) as IDisplayable;
                  if(_loc4_)
                  {
                     TooltipManager.show(_loc3_,_loc4_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"ec" + this._fighterId,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null);
                  }
                  _loc2_.addStep(new AddGfxEntityStep(1070,_loc1_.disposition.cellId));
               }
            }
            _loc2_.start();
         }
         executeCallbacks();
      }
   }
}
