package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceDuration extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceDuration() {
         super();
      }
      
      public var days:uint;
      
      public var hours:uint;
      
      public var minutes:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceDuration = new EffectInstanceDuration();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.days = this.days;
         _loc1_.hours = this.hours;
         _loc1_.minutes = this.minutes;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return this.days;
      }
      
      override public function get parameter1() : Object {
         return this.hours;
      }
      
      override public function get parameter2() : Object {
         return this.minutes;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         switch(param1)
         {
            case 0:
               this.days = uint(param2);
               break;
            case 1:
               this.hours = uint(param2);
               break;
            case 2:
               this.minutes = uint(param2);
               break;
         }
      }
   }
}
