package com.ankamagames.atouin.entities.behaviours.movements
{
   public class RunningMovementBehavior extends AnimatedMovementBehavior
   {
      
      public function RunningMovementBehavior()
      {
         super();
      }
      
      private static const RUN_LINEAR_VELOCITY:Number = 1 / 170;
      
      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1 / 255;
      
      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 1 / 150;
      
      private static const RUN_ANIMATION:String = "AnimCourse";
      
      public static function getInstance(param1:Number = 0.0) : RunningMovementBehavior
      {
         return getFromCache(param1,RunningMovementBehavior) as RunningMovementBehavior;
      }
      
      override protected function getLinearVelocity() : Number
      {
         return RUN_LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number
      {
         return RUN_HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number
      {
         return RUN_VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String
      {
         return RUN_ANIMATION;
      }
   }
}
