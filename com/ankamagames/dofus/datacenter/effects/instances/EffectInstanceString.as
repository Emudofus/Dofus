package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceString extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceString() {
         super();
      }
      
      public var text:String;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceString = new EffectInstanceString();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.text = this.text;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter3() : Object {
         return this.text;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         if(param1 == 3)
         {
            this.text = String(param2);
         }
      }
   }
}
