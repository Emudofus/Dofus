package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   
   public class BenchmarkCharacter extends AnimatedCharacter
   {
      
      public function BenchmarkCharacter(param1:int, param2:TiphonEntityLook) {
         super(param1,param2);
         _displayBehavior = AtouinDisplayBehavior.getInstance();
         _movementBehavior = BenchmarkMovementBehavior.getInstance();
         setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE,DirectionsEnum.RIGHT);
         this.id = param1;
      }
      
      override public function move(param1:MovementPath, param2:Function=null) : void {
         if(!param1.start.equals(position))
         {
            _log.warn("Unsynchronized position for entity " + id + ", jumping from " + position + " to " + param1.start + ".");
            jump(param1.start);
         }
         _movementBehavior = BenchmarkMovementBehavior.getInstance();
         _movementBehavior.move(this,param1,param2);
      }
   }
}
