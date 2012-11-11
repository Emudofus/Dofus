package com.ankamagames.atouin.entities.behaviours.movements
{
    import com.ankamagames.jerakine.utils.errors.*;

    public class MountedMovementBehavior extends AnimatedMovementBehavior
    {
        private static const RUN_LINEAR_VELOCITY:Number = 0.00740741;
        private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.005;
        private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 0.00833333;
        private static const RUN_ANIMATION:String = "AnimCourse";
        private static var _self:MountedMovementBehavior;

        public function MountedMovementBehavior()
        {
            if (_self)
            {
                throw new SingletonError("Warning : MountedMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
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
            return RUN_ANIMATION;
        }// end function

        public static function getInstance() : MountedMovementBehavior
        {
            if (!_self)
            {
                _self = new MountedMovementBehavior;
            }
            return _self;
        }// end function

    }
}
