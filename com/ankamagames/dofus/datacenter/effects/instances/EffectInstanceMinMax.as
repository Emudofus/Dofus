package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceMinMax extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceMinMax() {
         super();
      }
      
      public var min:uint;
      
      public var max:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceMinMax = new EffectInstanceMinMax();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.min = this.min;
         _loc1_.max = this.max;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return this.min;
      }
      
      override public function get parameter1() : Object {
         return this.min != this.max?this.max:null;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         switch(param1)
         {
            case 0:
               this.min = uint(param2);
               break;
            case 1:
               this.max = uint(param2);
               break;
         }
      }
   }
}
