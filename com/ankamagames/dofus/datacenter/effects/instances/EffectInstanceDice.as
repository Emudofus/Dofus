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
         var o:EffectInstanceDice = new EffectInstanceDice();
         o.rawZone = rawZone;
         o.effectId = effectId;
         o.duration = duration;
         o.delay = delay;
         o.diceNum = this.diceNum;
         o.diceSide = this.diceSide;
         o.value = value;
         o.random = random;
         o.group = group;
         o.hidden = hidden;
         o.targetId = targetId;
         o.targetMask = targetMask;
         o.delay = delay;
         o.triggers = triggers;
         o.order = order;
         return o;
      }
      
      override public function get parameter0() : Object {
         return !(this.diceNum == 0)?this.diceNum:null;
      }
      
      override public function get parameter1() : Object {
         return !(this.diceSide == 0)?this.diceSide:null;
      }
      
      override public function get parameter2() : Object {
         return !(value == 0)?value:null;
      }
      
      override public function setParameter(paramIndex:uint, value:*) : void {
         switch(paramIndex)
         {
            case 0:
               this.diceNum = uint(value);
               break;
            case 1:
               this.diceSide = uint(value);
               break;
            case 2:
               this.value = int(value);
               break;
         }
      }
      
      override public function add(term:*) : EffectInstance {
         if(term is EffectInstanceDice)
         {
            this.diceNum = this.diceNum + term.diceNum;
            this.diceSide = this.diceSide + term.diceSide;
            forceDescriptionRefresh();
         }
         else if(term is EffectInstanceInteger)
         {
            this.diceNum = this.diceNum + term.value;
            this.diceSide = !(this.diceSide == 0)?this.diceSide + term.value:0;
            forceDescriptionRefresh();
         }
         else
         {
            _log.error(term + " cannot be added to EffectInstanceDice.");
         }
         
         return this;
      }
   }
}
