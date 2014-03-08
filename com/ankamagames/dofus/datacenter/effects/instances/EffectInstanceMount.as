package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceMount extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceMount() {
         super();
      }
      
      public var date:Number;
      
      public var modelId:uint;
      
      public var mountId:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceMount = new EffectInstanceMount();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.date = this.date;
         _loc1_.modelId = this.modelId;
         _loc1_.mountId = this.mountId;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return this.date;
      }
      
      override public function get parameter1() : Object {
         return this.modelId;
      }
      
      override public function get parameter2() : Object {
         return this.mountId;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         switch(param1)
         {
            case 0:
               this.date = Number(param2);
               break;
            case 1:
               this.modelId = uint(param2);
               break;
            case 2:
               this.mountId = uint(param2);
               break;
         }
      }
   }
}
