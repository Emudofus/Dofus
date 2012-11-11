package com.ankamagames.atouin.entities.behaviours.movements
{
    import com.ankamagames.jerakine.utils.errors.*;

    public class FantomMovementBehavior extends AnimatedMovementBehavior
    {
        private static const WALK_LINEAR_VELOCITY:Number = 0.00147059;
        private static const WALK_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.000980392;
        private static const WALK_VERTICAL_DIAGONAL_VELOCITY:Number = 0.00117647;
        private static const WALK_ANIMATION:String = "AnimMarche";
        private static var _self:FantomMovementBehavior;

        public function FantomMovementBehavior()
        {
            if (_self)
            {
                throw new SingletonError("Warning : FantomMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
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

        public static function getInstance() : FantomMovementBehavior
        {
            if (!_self)
            {
                _self = new FantomMovementBehavior;
            }
            return _self;
        }// end function

    }
}
