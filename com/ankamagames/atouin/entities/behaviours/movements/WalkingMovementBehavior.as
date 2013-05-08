package com.ankamagames.atouin.entities.behaviours.movements
{
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class WalkingMovementBehavior extends AnimatedMovementBehavior
   {
         

      public function WalkingMovementBehavior() {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : WalkingMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            return;
         }
      }

      private static const WALK_LINEAR_VELOCITY:Number = 1/480;

      private static const WALK_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1/510;

      private static const WALK_VERTICAL_DIAGONAL_VELOCITY:Number = 1/425;

      private static const WALK_ANIMATION:String = "AnimMarche";

      private static var _self:WalkingMovementBehavior;

      public static function getInstance() : WalkingMovementBehavior {
         if(!_self)
         {
            _self=new WalkingMovementBehavior();
         }
         return _self;
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