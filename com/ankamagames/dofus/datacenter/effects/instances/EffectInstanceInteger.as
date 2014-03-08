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
         var _loc1_:EffectInstanceInteger = new EffectInstanceInteger();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.value = this.value;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.hidden = hidden;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return this.value;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         if(param1 == 2)
         {
            this.value = int(param2);
         }
      }
      
      override public function add(param1:*) : EffectInstance {
         if(param1 is EffectInstanceDice)
         {
            return param1.add(this);
         }
         if(param1 is EffectInstanceInteger)
         {
            this.value = this.value + param1.value;
            forceDescriptionRefresh();
         }
         else
         {
            _log.error(param1 + " cannot be added to EffectInstanceInteger.");
         }
         return this;
      }
   }
}
