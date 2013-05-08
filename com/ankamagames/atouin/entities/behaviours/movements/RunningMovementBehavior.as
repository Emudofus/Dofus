package com.ankamagames.atouin.entities.behaviours.movements
{
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class RunningMovementBehavior extends AnimatedMovementBehavior
   {
         

      public function RunningMovementBehavior() {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : RunningMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
         }
         else
         {
            return;
         }
      }

      private static const RUN_LINEAR_VELOCITY:Number = 1/170;

      private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 1/255;

      private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 1/150;

      private static const RUN_ANIMATION:String = "AnimCourse";

      private static var _self:RunningMovementBehavior;

      public static function getInstance() : RunningMovementBehavior {
         if(!_self)
         {
            _self=new RunningMovementBehavior();
         }
         return _self;
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