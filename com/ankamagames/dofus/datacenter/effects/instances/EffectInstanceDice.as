package com.ankamagames.dofus.datacenter.effects.instances
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   
   public class EffectInstanceDice extends EffectInstanceInteger implements IDataCenter
   {
      
      public function EffectInstanceDice() {
         super();
      }
      
      public var diceNum:uint;
      
      public var diceSide:uint;
      
      override public function clone() : EffectInstance {
         var _loc1_:EffectInstanceDice = new EffectInstanceDice();
         _loc1_.rawZone = rawZone;
         _loc1_.effectId = effectId;
         _loc1_.duration = duration;
         _loc1_.delay = delay;
         _loc1_.diceNum = this.diceNum;
         _loc1_.diceSide = this.diceSide;
         _loc1_.value = value;
         _loc1_.random = random;
         _loc1_.group = group;
         _loc1_.hidden = hidden;
         _loc1_.targetId = targetId;
         _loc1_.targetMask = targetMask;
         return _loc1_;
      }
      
      override public function get parameter0() : Object {
         return this.diceNum != 0?this.diceNum:null;
      }
      
      override public function get parameter1() : Object {
         return this.diceSide != 0?this.diceSide:null;
      }
      
      override public function get parameter2() : Object {
         return value != 0?value:null;
      }
      
      override public function setParameter(param1:uint, param2:*) : void {
         switch(param1)
         {
            case 0:
               this.diceNum = uint(param2);
               break;
            case 1:
               this.diceSide = uint(param2);
               break;
            case 2:
               this.value = int(param2);
               break;
         }
      }
      
      override public function add(param1:*) : EffectInstance {
         if(param1 is EffectInstanceDice)
         {
            this.diceNum = this.diceNum + param1.diceNum;
            this.diceSide = this.diceSide + param1.diceSide;
            forceDescriptionRefresh();
         }
         else
         {
            if(param1 is EffectInstanceInteger)
            {
               this.diceNum = this.diceNum + param1.value;
               this.diceSide = this.diceSide != 0?this.diceSide + param1.value:0;
               forceDescriptionRefresh();
            }
            else
            {
               _log.error(param1 + " cannot be added to EffectInstanceDice.");
            }
         }
         return this;
      }
   }
}
