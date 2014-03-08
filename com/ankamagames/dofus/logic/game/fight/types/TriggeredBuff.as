package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTriggeredEffect;
   
   public class TriggeredBuff extends BasicBuff
   {
      
      public function TriggeredBuff(effect:FightTriggeredEffect=null, castingSpell:CastingSpell=null, actionId:uint=0) {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.param1,effect.param2,effect.param3);
            this.delay = effect.delay;
            _effect.delay = this.delay;
         }
      }
      
      public var delay:int;
      
      override public function initParam(param1:int, param2:int, param3:int) : void {
         var min:* = 0;
         var max:* = 0;
         super.initParam(param1,param2,param3);
         if(Effect.getEffectById(actionId).forceMinMax)
         {
            min = param3 + param1;
            max = param1 * param2 + param3;
            if(min == max)
            {
               param1 = min;
               param2 = param3 = 0;
            }
            else
            {
               if(min > max)
               {
                  param1 = max;
                  param2 = min;
                  param3 = 0;
               }
               else
               {
                  param1 = min;
                  param2 = max;
                  param3 = 0;
               }
            }
         }
      }
      
      override public function clone(id:int=0) : BasicBuff {
         var tb:TriggeredBuff = new TriggeredBuff();
         tb.id = uid;
         tb.uid = uid;
         tb.actionId = actionId;
         tb.targetId = targetId;
         tb.castingSpell = castingSpell;
         tb.duration = duration;
         tb.dispelable = dispelable;
         tb.source = source;
         tb.aliveSource = aliveSource;
         tb.parentBoostUid = parentBoostUid;
         tb.initParam(param1,param2,param3);
         tb.delay = this.delay;
         tb._effect.delay = this.delay;
         return tb;
      }
      
      override public function get active() : Boolean {
         return (this.delay > 0) || (super.active);
      }
      
      override public function get trigger() : Boolean {
         return true;
      }
      
      override public function incrementDuration(delta:int, dispellEffect:Boolean=false) : Boolean {
         if((this.delay > 0) && (!dispellEffect))
         {
            if(this.delay + delta >= 0)
            {
               this.delay--;
               effects.delay--;
            }
            else
            {
               delta = delta + this.delay;
               this.delay = 0;
               effects.delay = 0;
            }
         }
         if(delta != 0)
         {
            return super.incrementDuration(delta,dispellEffect);
         }
         return true;
      }
      
      override public function get unusableNextTurn() : Boolean {
         return (this.delay <= 1) && (super.unusableNextTurn);
      }
   }
}
