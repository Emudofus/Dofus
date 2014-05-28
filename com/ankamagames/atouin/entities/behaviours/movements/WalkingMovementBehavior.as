package com.ankamagames.atouin.entities.behaviours.movements
{
   public class WalkingMovementBehavior extends AnimatedMovementBehavior
   {
      
      public function WalkingMovementBehavior() {
         super();
      }
      
      private static const WALK_LINEAR_VELOCITY:Number = 0.0020833333333333333;
      
      private static const WALK_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.00196078431372549;
      
      private static const WALK_VERTICAL_DIAGONAL_VELOCITY:Number = 0.002352941176470588;
      
      private static const WALK_ANIMATION:String = "AnimMarche";
      
      public static function getInstance(speedAdjust:Number = 0.0) : WalkingMovementBehavior {
         return getFromCache(speedAdjust,WalkingMovementBehavior) as WalkingMovementBehavior;
      }
      
      override protected function getLinearVelocity() : Number {
         return WALK_LINEAR_VELOCITY;
      }
      
      override protected function getHorizontalDiagonalVelocity() : Number {
         return WALK_HORIZONTAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getVerticalDiagonalVelocity() : Number {
         return WALK_VERTICAL_DIAGONAL_VELOCITY;
      }
      
      override protected function getAnimation() : String {
         return WALK_ANIMATION;
      }
   }
}
