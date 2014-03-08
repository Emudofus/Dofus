package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTriggeredEffect;
   
   public class TriggeredBuff extends BasicBuff
   {
      
      public function TriggeredBuff(param1:FightTriggeredEffect=null, param2:CastingSpell=null, param3:uint=0) {
         if(param1)
         {
            super(param1,param2,param3,param1.param1,param1.param2,param1.param3);
            this.delay = param1.delay;
            _effect.delay = this.delay;
         }
      }
      
      public var delay:int;
      
      override public function initParam(param1:int, param2:int, param3:int) : void {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         super.initParam(param1,param2,param3);
         if(Effect.getEffectById(actionId).forceMinMax)
         {
            _loc4_ = param3 + param1;
            _loc5_ = param1 * param2 + param3;
            if(_loc4_ == _loc5_)
            {
               param1 = _loc4_;
               param2 = param3 = 0;
            }
            else
            {
               if(_loc4_ > _loc5_)
               {
                  param1 = _loc5_;
                  param2 = _loc4_;
                  param3 = 0;
               }
               else
               {
                  param1 = _loc4_;
                  param2 = _loc5_;
                  param3 = 0;
               }
            }
         }
      }
      
      override public function clone(param1:int=0) : BasicBuff {
         var _loc2_:TriggeredBuff = new TriggeredBuff();
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
         _loc2_.delay = this.delay;
         _loc2_._effect.delay = this.delay;
         return _loc2_;
      }
      
      override public function get active() : Boolean {
         return this.delay > 0 || (super.active);
      }
      
      override public function get trigger() : Boolean {
         return true;
      }
      
      override public function incrementDuration(param1:int, param2:Boolean=false) : Boolean {
         if(this.delay > 0 && !param2)
         {
            if(this.delay + param1 >= 0)
            {
               this.delay--;
               effects.delay--;
            }
            else
            {
               param1 = param1 + this.delay;
               this.delay = 0;
               effects.delay = 0;
            }
         }
         if(param1 != 0)
         {
            return super.incrementDuration(param1,param2);
         }
         return true;
      }
      
      override public function get unusableNextTurn() : Boolean {
         return this.delay <= 1 && (super.unusableNextTurn);
      }
   }
}
