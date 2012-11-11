package com.ankamagames.atouin.entities.behaviours.movements
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.display.*;
    import flash.geom.*;

    public class ParableMovementBehavior extends AnimatedMovementBehavior
    {
        private static const LINEAR_VELOCITY:Number = 0.0025;
        private static const HORIZONTAL_DIAGONAL_VELOCITY:Number = 0.002;
        private static const VERTICAL_DIAGONAL_VELOCITY:Number = 0.00222222;
        private static const ANIMATION:String = "FX";
        private static var _curvePoint:Point;
        private static var _velocity:Number;
        private static var _angle:Number;
        private static var _self:ParableMovementBehavior;

        public function ParableMovementBehavior()
        {
            if (_self)
            {
                throw new SingletonError("Warning : ParableMovementBehavior is a singleton class and shoulnd\'t be instancied directly!");
            }
            return;
        }// end function

        override protected function getLinearVelocity() : Number
        {
            return LINEAR_VELOCITY;
        }// end function

        override protected function getHorizontalDiagonalVelocity() : Number
        {
            return HORIZONTAL_DIAGONAL_VELOCITY;
        }// end function

        override protected function getVerticalDiagonalVelocity() : Number
        {
            return VERTICAL_DIAGONAL_VELOCITY;
        }// end function

        override protected function getAnimation() : String
        {
            return ANIMATION;
        }// end function

        override public function move(param1:IMovable, param2:MovementPath, param3:Function = null) : void
        {
            var _loc_4:* = new TweenEntityData();
            new TweenEntityData().path = param2;
            _loc_4.entity = param1;
            var _loc_5:* = InteractiveCellManager.getInstance().getCell(_loc_4.path.start.cellId);
            var _loc_6:* = InteractiveCellManager.getInstance().getCell(_loc_4.path.end.cellId);
            var _loc_7:* = new Point(_loc_5.x, _loc_5.y);
            var _loc_8:* = new Point(_loc_6.x, _loc_6.y);
            var _loc_9:* = Point.distance(_loc_7, _loc_8);
            _curvePoint = Point.interpolate(_loc_7, _loc_8, 0.5);
            _curvePoint.y = _curvePoint.y - _loc_9 / 2;
            _velocity = 1 / (500 + param2.start.distanceTo(param2.end) * 50);
            _angle = this.checkAngle(_loc_7, _loc_8);
            var _loc_10:* = DisplayObject(_loc_4.entity);
            DisplayObject(_loc_4.entity).rotation = DisplayObject(_loc_4.entity).rotation - (_angle + (90 - _angle) / 2);
            initMovement(param1, _loc_4);
            return;
        }// end function

        override protected function processMovement(param1:TweenEntityData, param2:uint) : void
        {
            var _loc_8:* = NaN;
            param1.barycentre = _velocity * (param2 - param1.start);
            if (param1.barycentre > 1)
            {
                param1.barycentre = 1;
            }
            var _loc_3:* = DisplayObject(param1.entity);
            var _loc_4:* = InteractiveCellManager.getInstance().getCell(param1.currentCell.cellId);
            var _loc_5:* = InteractiveCellManager.getInstance().getCell(param1.nextCell.cellId);
            _loc_3.x = (1 - param1.barycentre) * (1 - param1.barycentre) * _loc_4.x + 2 * (1 - param1.barycentre) * param1.barycentre * _curvePoint.x + param1.barycentre * param1.barycentre * _loc_5.x;
            _loc_3.y = (1 - param1.barycentre) * (1 - param1.barycentre) * _loc_4.y + 2 * (1 - param1.barycentre) * param1.barycentre * _curvePoint.y + param1.barycentre * param1.barycentre * _loc_5.y;
            var _loc_6:* = -(_angle + (90 - _angle) / 2);
            var _loc_7:* = 2.5 * (90 + _loc_6) * param1.barycentre;
            _loc_3.rotation = _loc_6 + _loc_7;
            if (_loc_5.y > _loc_4.y)
            {
                _loc_8 = 2 * (90 + _loc_6) * (1 - param1.barycentre);
                _loc_3.rotation = -_loc_6 - _loc_8;
            }
            _loc_3.scaleX = 1 - param1.barycentre * (90 - Math.abs(90 - _angle)) / 90;
            if (!param1.wasOrdered && param1.barycentre > 0.5)
            {
                EntitiesDisplayManager.getInstance().orderEntity(_loc_3, _loc_5);
            }
            if (param1.barycentre >= 1)
            {
                IEntity(param1.entity).position = param1.nextCell;
                goNextCell(IMovable(param1.entity));
                EntitiesManager.getInstance().removeEntity(IEntity(param1.entity).id);
            }
            return;
        }// end function

        private function checkAngle(param1:Point, param2:Point) : Number
        {
            var _loc_3:* = Point.distance(param1, new Point(param2.x, param1.y));
            var _loc_4:* = Point.distance(param1, param2);
            var _loc_5:* = Math.acos(_loc_3 / _loc_4) * 180 / Math.PI;
            if (param1.x > param2.x)
            {
                _loc_5 = 180 - _loc_5;
            }
            return _loc_5;
        }// end function

        public static function getInstance() : ParableMovementBehavior
        {
            if (!_self)
            {
                _self = new ParableMovementBehavior;
            }
            return _self;
        }// end function

    }
}
