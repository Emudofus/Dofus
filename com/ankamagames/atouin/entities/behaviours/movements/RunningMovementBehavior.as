package com.ankamagames.atouin.entities.behaviours.movements
{
   public class RunningMovementBehavior extends AnimatedMovementBehavior
   {
      
      public function RunningMovementBehavior() {
         super();
      }
      
      private static const RUN_LINEAR_VELOCITY:Number = 0.0058823529411764705;
      
      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.00392156862745098;
      
      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 0.006666666666666667;
      
      private static const RUN_ANIMATION:String = "AnimCourse";
      
      public static function getInstance(speedAdjust:Number = 0.0) : RunningMovementBehavior {
         return getFromCache(speedAdjust,RunningMovementBehavior) as RunningMovementBehavior;
      }
      
      override protected function getLinearVelocity() : Number {
         return RUN_LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number {
         return RUN_HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number {
         return RUN_VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String {
         return RUN_ANIMATION;
      }
   }
}
