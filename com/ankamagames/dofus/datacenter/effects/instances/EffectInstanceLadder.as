package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   
   public class EffectInstanceLadder extends EffectInstanceCreature implements IDataCenter
   {
      
      public function EffectInstanceLadder() {
         super();
      }
      
      public var monsterCount:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceLadder = new EffectInstanceLadder();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.monsterFamilyId = monsterFamilyId;
         _loc1_.monsterCount = this.monsterCount;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return monsterFamilyId;
      }
      
      override public function get parameter2() : Object {
         return this.monsterCount;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         switch(param1)
         {
            case 0:
               monsterFamilyId = uint(param2);
               break;
            case 2:
               this.monsterCount = uint(param2);
               break;
         }
      }
   }
}
