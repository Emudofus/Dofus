package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.sequencer.ISequencableListener;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public class FightDisplayBuffStep extends AbstractSequencable implements IFightStep, ISequencableListener
   {
      
      public function FightDisplayBuffStep(param1:BasicBuff) {
         super();
         this._buff = param1;
      }
      
      private var _buff:BasicBuff;
      
      private var _virtualStep:IFightStep;
      
      public function get stepType() : String {
         return "displayBuff";
      }
      
      override public function start() : void {
         var _loc2_:String = null;
         var _loc1_:* = true;
         if(this._buff.actionId == ActionIdConverter.ACTION_CHARACTER_UPDATE_BOOST)
         {
            _loc1_ = !BuffManager.getInstance().updateBuff(this._buff);
         }
         else
         {
            if(_loc1_)
            {
               if(this._buff is StatBuff)
               {
                  _loc2_ = (this._buff as StatBuff).statName;
                  switch(_loc2_)
                  {
                     case "movementPoints":
                        this._virtualStep = new FightMovementPointsVariationStep(this._buff.targetId,(this._buff as StatBuff).delta,false,false,false);
                        break;
                     case "actionPoints":
                        this._virtualStep = new FightActionPointsVariationStep(this._buff.targetId,(this._buff as StatBuff).delta,false,false,false);
                        break;
                  }
               }
               BuffManager.getInstance().addBuff(this._buff);
            }
         }
         if(!this._virtualStep)
         {
            executeCallbacks();
         }
         else
         {
            this._virtualStep.addListener(this);
            this._virtualStep.start();
         }
      }
      
      public function stepFinished(param1:ISequencable, param2:Boolean=false) : void {
         this._virtualStep.removeListener(this);
         executeCallbacks();
      }
   }
}
