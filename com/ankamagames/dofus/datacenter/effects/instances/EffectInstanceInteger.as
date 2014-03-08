package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceInteger extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceInteger() {
         super();
      }
      
      public var value:int;
      
      override public function clone() : EffectInstance {
         var o:EffectInstanceInteger = new EffectInstanceInteger();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.value = this.value;
         o.random = random;
         o.group = group;
         o.hidden = hidden;
         o.targetId = targetId;
         o.targetMask = targetMask;
         return o;
      }
      
      override public function get parameter0() : Object {
         return this.value;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void {
         if(paramIndex == 2)
         {
            this.value = int(value);
         }
      }
      
      override public function add(term:*) : EffectInstance {
         if(term is EffectInstanceDice)
         {
            return term.add(this);
         }
         if(term is EffectInstanceInteger)
         {
            this.value = this.value + term.value;
            forceDescriptionRefresh();
         }
         else
         {
            _log.error(term + " cannot be added to EffectInstanceInteger.");
         }
         return this;
      }
   }
}
