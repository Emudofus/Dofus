package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceCreature extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceCreature() {
         super();
      }
      
      public var monsterFamilyId:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceCreature = new EffectInstanceCreature();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.monsterFamilyId = this.monsterFamilyId;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return this.monsterFamilyId;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         if(param1 == 0)
         {
            this.monsterFamilyId = uint(param2);
         }
      }
   }
}
