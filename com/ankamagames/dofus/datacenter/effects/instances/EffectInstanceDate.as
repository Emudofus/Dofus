package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EffectInstanceDate extends EffectInstance implements IDataCenter
   {
      
      public function EffectInstanceDate() {
         super();
      }
      
      public var year:uint;
      
      public var month:uint;
      
      public var day:uint;
      
      public var hour:uint;
      
      public var minute:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceDate = new EffectInstanceDate();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.year = this.year;
         _loc1_.month = this.month;
         _loc1_.day = this.day;
         _loc1_.hour = this.hour;
         _loc1_.minute = this.minute;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return String(this.year);
      }
      
      override public function get parameter1() : Object {
         var _loc1_:String = this.month > 9?String(this.month):"0" + String(this.month);
         var _loc2_:String = this.day > 9?String(this.day):"0" + String(this.day);
         return _loc1_ + _loc2_;
      }
      
      override public function get parameter2() : Object {
         var _loc1_:String = this.hour > 9?String(this.hour):"0" + String(this.hour);
         var _loc2_:String = this.minute > 9?String(this.minute):"0" + String(this.minute);
         return _loc1_ + _loc2_;
      }
      
      override public function get parameter3() : Object {
         return this.month;
      }
      
      override public function get parameter4() : Object {
         return this.day;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         switch(param1)
         {
            case 0:
               this.year = uint(param2);
               break;
            case 1:
               this.month = uint(String(param2).substr(0,2));
               this.day = uint(String(param2).substr(2,2));
               break;
            case 2:
               this.hour = uint(String(param2).substr(0,2));
               this.minute = uint(String(param2).substr(2,2));
               break;
            case 3:
               this.month = uint(param2);
               break;
            case 4:
               this.day = uint(param2);
               break;
         }
      }
   }
}
