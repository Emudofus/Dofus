package com.ankamagames.atouin.entities.behaviours.movements
{
    import com.ankamagames.jerakine.utils.errors.*;

    public class SlideMovementBehavior extends AnimatedMovementBehavior
    {
        private static const RUN_LINEAR_VELOCITY:Number = 0.0176471;
        private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.0117647;
        private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 0.02;
        private static const RUN_ANIMATION:String = "AnimStatique";
        private static var _self:SlideMovementBehavior;

        public function SlideMovementBehavior()
        {
            if (_self)
            {
                throw new SingletonError("Warning : SlideMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
            }
            return;
        }// end function

        override protected function getLinearVelocity() : Number
        {
            return RUN_LINEAR_VELOCITY;
        }// end function

        override protected function getHorizontalDiagonalVelocity() : Number
        {
            return RUN_HORIZONTAL_DIAGONAL_VELOCITY;
        }// end function

        override protected function getVerticalDiagonalVelocity() : Number
        {
            return RUN_VERTICAL_DIAGONAL_VELOCITY;
        }// end function

        override protected function getAnimation() : String
        {
            return null;
        }// end function

        override protected function mustChangeOrientation() : Boolean
        {
            return false;
        }// end function

        public static function getInstance() : SlideMovementBehavior
        {
            if (!_self)
            {
                _self = new SlideMovementBehavior;
            }
            return _self;
        }// end function

    }
}
