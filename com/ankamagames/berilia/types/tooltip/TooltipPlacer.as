package com.ankamagames.berilia.types.tooltip
{
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TooltipPlacer extends Object
    {
        static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipPlacer));
        private static const _anchors:Array = [];
        private static var _init:Boolean;

        public function TooltipPlacer()
        {
            return;
        }// end function

        private static function init() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (_init)
            {
                return;
            }
            _init = true;
            var _loc_1:* = [LocationEnum.POINT_TOPLEFT, LocationEnum.POINT_TOP, LocationEnum.POINT_TOPRIGHT, LocationEnum.POINT_LEFT, LocationEnum.POINT_CENTER, LocationEnum.POINT_RIGHT, LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_BOTTOMRIGHT];
            for each (_loc_2 in _loc_1)
            {
                
                for each (_loc_3 in _loc_1)
                {
                    
                    _anchors.push({p1:_loc_2, p2:_loc_3});
                }
            }
            return;
        }// end function

        private static function getAnchors() : Array
        {
            init();
            return _anchors.concat();
        }// end function

        public static function place(param1:DisplayObject, param2:IRectangle, param3:uint = 6, param4:uint = 0, param5:int = 3) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_6:* = false;
            var _loc_7:* = param1.getBounds(param1);
            var _loc_8:* = getAnchors();
            while (!_loc_6)
            {
                
                _loc_9 = new Point(param2.x, param2.y);
                _loc_10 = new Point(param1.x, param1.y);
                _loc_11 = new Rectangle2(param1.x, param1.y, param1.width, param1.height);
                processAnchor(_loc_10, _loc_11, param3);
                processAnchor(_loc_9, param2, param4);
                _loc_12 = makeOffset(param3, param5);
                _loc_9.x = _loc_9.x - (_loc_10.x - _loc_12.x + _loc_7.left);
                _loc_9.y = _loc_9.y - (_loc_10.y - _loc_12.y);
                _loc_13 = new Rectangle2(_loc_9.x, _loc_9.y, _loc_11.width, _loc_11.height);
                if (_loc_13.y < 0)
                {
                    _loc_13.y = 0;
                }
                if (_loc_13.x < 0)
                {
                    _loc_13.x = 0;
                }
                if (_loc_13.y + _loc_13.height > StageShareManager.startHeight)
                {
                    _loc_13.y = _loc_13.y - (_loc_13.height + _loc_13.y - StageShareManager.startHeight);
                }
                if (_loc_13.x + _loc_13.width > StageShareManager.startWidth)
                {
                    _loc_13.x = _loc_13.x - (_loc_13.width + _loc_13.x - StageShareManager.startWidth);
                }
                _loc_6 = !hitTest(_loc_13, param2);
                if (!_loc_6)
                {
                    _loc_14 = _loc_8.shift();
                    if (!_loc_14)
                    {
                        break;
                    }
                    param3 = _loc_14.p1;
                    param4 = _loc_14.p2;
                }
            }
            param1.x = _loc_13.x;
            param1.y = _loc_13.y;
            return;
        }// end function

        public static function placeWithArrow(param1:DisplayObject, param2:IRectangle) : Object
        {
            var _loc_3:* = new Point(param1.x, param1.y);
            var _loc_4:* = {bottomFlip:false, leftFlip:false};
            _loc_3.x = param2.x + param2.width / 2 + 5;
            _loc_3.y = param2.y - param1.height;
            if (_loc_3.x + param1.width > StageShareManager.startWidth)
            {
                _loc_4.leftFlip = true;
                _loc_3.x = _loc_3.x - (param1.width + 10);
            }
            if (_loc_3.y < 0)
            {
                _loc_4.bottomFlip = true;
                _loc_3.y = param2.y + param2.height;
            }
            param1.x = _loc_3.x;
            param1.y = _loc_3.y;
            return _loc_4;
        }// end function

        private static function hitTest(param1:IRectangle, param2:IRectangle) : Boolean
        {
            var _loc_3:* = new Rectangle(param1.x, param1.y, param1.width, param1.height);
            var _loc_4:* = new Rectangle(param2.x, param2.y, param2.width, param2.height);
            return _loc_3.intersects(_loc_4);
        }// end function

        private static function processAnchor(param1:Point, param2:IRectangle, param3:uint) : Point
        {
            switch(param3)
            {
                case LocationEnum.POINT_TOPLEFT:
                {
                    break;
                }
                case LocationEnum.POINT_TOP:
                {
                    param1.x = param1.x + param2.width / 2;
                    break;
                }
                case LocationEnum.POINT_TOPRIGHT:
                {
                    param1.x = param1.x + param2.width;
                    break;
                }
                case LocationEnum.POINT_LEFT:
                {
                    param1.y = param1.y + param2.height / 2;
                    break;
                }
                case LocationEnum.POINT_CENTER:
                {
                    param1.x = param1.x + param2.width / 2;
                    param1.y = param1.y + param2.height / 2;
                    break;
                }
                case LocationEnum.POINT_RIGHT:
                {
                    param1.x = param1.x + param2.width;
                    param1.y = param1.y + param2.height / 2;
                    break;
                }
                case LocationEnum.POINT_BOTTOMLEFT:
                {
                    param1.y = param1.y + param2.height;
                    break;
                }
                case LocationEnum.POINT_BOTTOM:
                {
                    param1.x = param1.x + param2.width / 2;
                    param1.y = param1.y + param2.height;
                    break;
                }
                case LocationEnum.POINT_BOTTOMRIGHT:
                {
                    param1.x = param1.x + param2.width;
                    param1.y = param1.y + param2.height;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return param1;
        }// end function

        private static function makeOffset(param1:uint, param2:uint) : Point
        {
            var _loc_3:* = new Point();
            switch(param1)
            {
                case LocationEnum.POINT_TOPLEFT:
                case LocationEnum.POINT_BOTTOMLEFT:
                case LocationEnum.POINT_LEFT:
                {
                    _loc_3.x = param2;
                    break;
                }
                case LocationEnum.POINT_TOP:
                {
                    break;
                }
                case LocationEnum.POINT_BOTTOMRIGHT:
                case LocationEnum.POINT_TOPRIGHT:
                case LocationEnum.POINT_RIGHT:
                {
                    _loc_3.x = -param2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(param1)
            {
                case LocationEnum.POINT_TOPLEFT:
                case LocationEnum.POINT_TOP:
                case LocationEnum.POINT_TOPRIGHT:
                {
                    _loc_3.y = param2;
                    break;
                }
                case LocationEnum.POINT_BOTTOMLEFT:
                case LocationEnum.POINT_BOTTOMRIGHT:
                case LocationEnum.POINT_BOTTOM:
                {
                    _loc_3.y = -param2;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

    }
}
