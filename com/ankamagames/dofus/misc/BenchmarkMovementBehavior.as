package com.ankamagames.dofus.misc
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.entities.behaviours.movements.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class BenchmarkMovementBehavior extends AnimatedMovementBehavior
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(BenchmarkMovementBehavior));
        private static var _self:BenchmarkMovementBehavior;
        private static const RUN_LINEAR_VELOCITY:Number = 0.00588235;
        private static const RUN_HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.00392157;
        private static const RUN_VERTICAL_DIAGONAL_VELOCITY:Number = 0.00470588;
        private static const RUN_ANIMATION:String = "AnimCourse";

        public function BenchmarkMovementBehavior()
        {
            if (_self)
            {
                throw new SingletonError("Warning : RunningMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
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

        override protected function stopMovement(param1:IMovable) : void
        {
            super.stopMovement(param1);
            var _loc_2:* = getRandomPath(param1);
            if (_loc_2.path.length > 0)
            {
                param1.move(_loc_2);
            }
            else
            {
                stop(param1, true);
                AnimatedCharacter(param1).remove();
            }
            return;
        }// end function

        public static function getInstance() : BenchmarkMovementBehavior
        {
            if (!_self)
            {
                _self = new BenchmarkMovementBehavior;
            }
            return _self;
        }// end function

        public static function getRandomCell() : MapPoint
        {
            var _loc_1:* = 40;
            var _loc_2:* = MapPoint.fromCellId(Math.floor(Math.random() * AtouinConstants.MAP_CELLS_COUNT));
            while (!MapPoint.isInMap(_loc_2.x, _loc_2.y) && --_loc_1)
            {
                
                _loc_2 = MapPoint.fromCellId(Math.floor(Math.random() * AtouinConstants.MAP_CELLS_COUNT));
            }
            return _loc_2;
        }// end function

        public static function getRandomPath(param1:IMovable) : MovementPath
        {
            var _loc_6:* = 0;
            var _loc_2:* = new MovementPath();
            _loc_2.start = param1.position;
            var _loc_3:* = new Array();
            var _loc_4:* = -1;
            while (_loc_4 < 2)
            {
                
                _loc_6 = -1;
                while (_loc_6 < 2)
                {
                    
                    if (MapPoint.isInMap(_loc_2.start.x + _loc_4, _loc_2.start.y + _loc_6) && (_loc_4 != 0 || _loc_6 != 0) && DataMapProvider.getInstance().pointMov(_loc_2.start.x + _loc_4, _loc_2.start.y + _loc_6))
                    {
                        _loc_3.push(MapPoint.fromCoords(_loc_2.start.x + _loc_4, _loc_2.start.y + _loc_6));
                    }
                    _loc_6++;
                }
                _loc_4++;
            }
            _loc_2.end = _loc_3[Math.floor(Math.random() * _loc_3.length)];
            var _loc_5:* = new PathElement();
            new PathElement().step = _loc_2.start;
            _loc_5.orientation = _loc_2.start.orientationTo(_loc_2.end);
            _loc_2.addPoint(_loc_5);
            return _loc_2;
        }// end function

    }
}
