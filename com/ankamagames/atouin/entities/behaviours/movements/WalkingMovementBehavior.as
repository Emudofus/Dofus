package com.ankamagames.atouin.entities.behaviours.movements
{
    import com.ankamagames.jerakine.utils.errors.*;

    public class WalkingMovementBehavior extends AnimatedMovementBehavior
    {
        private static const WALK_LINEAR_VELOCITY:Number = 0.00208333;
        private static const WALK_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.00196078;
        private static const WALK_VERTICAL_DIAGONAL_VELOCITY:Number = 0.00235294;
        private static const WALK_ANIMATION:String = "AnimMarche";
        private static var _self:WalkingMovementBehavior;

        public function WalkingMovementBehavior()
        {
            if (_self)
            {
                throw new SingletonError("Warning : WalkingMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
            }
            return;
        }// end function

        override protected function getLinearVelocity() : Number
        {
            return WALK_LINEAR_VELOCITY;
        }// end function

        override protected function getHorizontalDiagonalVelocity() : Number
        {
            return WALK_HORIZONTAL_DIAGONAL_VELOCITY;
        }// end function

        override protected function getVerticalDiagonalVelocity() : Number
        {
            return WALK_VERTICAL_DIAGONAL_VELOCITY;
        }// end function

        override protected function getAnimation() : String
        {
            return WALK_ANIMATION;
        }// end function

        public static function getInstance() : WalkingMovementBehavior
        {
            if (!_self)
            {
                _self = new WalkingMovementBehavior;
            }
            return _self;
        }// end function

    }
}
