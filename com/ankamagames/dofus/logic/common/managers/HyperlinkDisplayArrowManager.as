package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class HyperlinkDisplayArrowManager extends Object
    {
        private static const ARROW_CLIP:Class = HyperlinkDisplayArrowManager_ARROW_CLIP;
        private static var _arrowClip:MovieClip;
        private static var _arrowTimer:Timer;
        private static var _displayLastArrow:Boolean = false;
        private static var _lastArrowX:int;
        private static var _lastArrowY:int;
        private static var _lastArrowPos:int;
        private static var _lastStrata:int;
        private static var _lastReverse:int;

        public function HyperlinkDisplayArrowManager()
        {
            return;
        }// end function

        public static function showArrow(param1:String, param2:String, param3:int = 0, param4:int = 0, param5:int = 5, param6:int = 0) : MovieClip
        {
            var _loc_9:UiRootContainer = null;
            var _loc_10:DisplayObject = null;
            var _loc_11:Rectangle = null;
            var _loc_7:* = getArrow(param6 == 1);
            var _loc_8:* = Berilia.getInstance().docMain.getChildAt(param5) as DisplayObjectContainer;
            (Berilia.getInstance().docMain.getChildAt(param5) as DisplayObjectContainer).addChild(_loc_7);
            if (isNaN(Number(param1)))
            {
                _loc_9 = Berilia.getInstance().getUi(param1);
                if (_loc_9)
                {
                    _loc_10 = _loc_9.getElement(param2);
                    if (_loc_10 && _loc_10.visible)
                    {
                        _loc_11 = _loc_10.getRect(_loc_8);
                        place(_arrowClip, _loc_11, param3);
                    }
                    else
                    {
                        _loc_8.removeChild(_loc_7);
                    }
                }
            }
            else
            {
                return showAbsoluteArrow(int(param1), int(param2), param3, param4, param5, param6);
            }
            if (param4 == 1)
            {
                _arrowClip.scaleX = _arrowClip.scaleX * -1;
            }
            if (param6)
            {
                _displayLastArrow = true;
                _lastArrowX = _loc_7.x;
                _lastArrowY = _loc_7.y;
                _lastArrowPos = param3;
                _lastStrata = param5;
                _lastReverse = _arrowClip.scaleX;
            }
            return _arrowClip;
        }// end function

        public static function showAbsoluteArrow(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:int = 5, param6:int = 0) : MovieClip
        {
            var _loc_7:* = getArrow(param6 == 1);
            DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(param5)).addChild(_loc_7);
            place(_loc_7, new Rectangle(param1, param2), param3);
            if (param4 == 1)
            {
                _arrowClip.scaleX = _arrowClip.scaleX * -1;
            }
            if (param6)
            {
                _displayLastArrow = true;
                _lastArrowX = _loc_7.x;
                _lastArrowY = _loc_7.y;
                _lastArrowPos = param3;
                _lastStrata = param5;
                _lastReverse = _arrowClip.scaleX;
            }
            return _loc_7;
        }// end function

        public static function showMapTransition(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 5, param6:int = 0) : MovieClip
        {
            var _loc_7:MovieClip = null;
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            _loc_7 = getArrow(param6 == 1);
            DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(param5)).addChild(_loc_7);
            switch(param2)
            {
                case DirectionsEnum.DOWN:
                {
                    _loc_8 = param3;
                    _loc_9 = 880;
                    _loc_10 = 1;
                    break;
                }
                case DirectionsEnum.LEFT:
                {
                    _loc_8 = 0;
                    _loc_9 = param3;
                    _loc_10 = 5;
                    break;
                }
                case DirectionsEnum.UP:
                {
                    _loc_8 = param3;
                    _loc_9 = 0;
                    _loc_10 = 7;
                    break;
                }
                case DirectionsEnum.RIGHT:
                {
                    _loc_8 = 1280;
                    _loc_9 = param3;
                    _loc_10 = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            place(_loc_7, new Rectangle(_loc_8, _loc_9), _loc_10);
            if (param4 == 1)
            {
                _arrowClip.scaleX = _arrowClip.scaleX * -1;
            }
            if (param6)
            {
                _displayLastArrow = true;
                _lastArrowX = _loc_7.x;
                _lastArrowY = _loc_7.y;
                _lastArrowPos = _loc_10;
                _lastStrata = param5;
                _lastReverse = _arrowClip.scaleX;
            }
            return _loc_7;
            return null;
        }// end function

        public static function destoyArrow(event:Event = null) : void
        {
            if (event)
            {
                if (_displayLastArrow)
                {
                    (Berilia.getInstance().docMain.getChildAt(_lastStrata) as DisplayObjectContainer).addChild(_arrowClip);
                    place(_arrowClip, new Rectangle(_lastArrowX, _lastArrowY), _lastArrowPos);
                    _arrowClip.scaleX = _lastReverse;
                    return;
                }
            }
            else
            {
                _displayLastArrow = false;
            }
            if (_arrowClip)
            {
                _arrowClip.gotoAndStop(1);
                if (_arrowClip.parent)
                {
                    _arrowClip.parent.removeChild(_arrowClip);
                }
            }
            return;
        }// end function

        private static function getArrow(param1:Boolean = false) : MovieClip
        {
            if (_arrowClip)
            {
                _arrowClip.gotoAndPlay(1);
            }
            else
            {
                _arrowClip = new ARROW_CLIP() as MovieClip;
                _arrowClip.mouseEnabled = false;
                _arrowClip.mouseChildren = false;
            }
            if (param1)
            {
                if (_arrowTimer)
                {
                    _arrowTimer.reset();
                }
            }
            else
            {
                if (_arrowTimer)
                {
                    _arrowTimer.reset();
                }
                else
                {
                    _arrowTimer = new Timer(2000, 1);
                    _arrowTimer.addEventListener(TimerEvent.TIMER, destoyArrow);
                }
                _arrowTimer.start();
            }
            return _arrowClip;
        }// end function

        public static function place(param1:MovieClip, param2:Rectangle, param3:int) : void
        {
            if (param3 == 0)
            {
                param1.scaleX = 1;
                param1.scaleY = 1;
                param1.x = int(param2.x);
                param1.y = int(param2.y);
            }
            else if (param3 == 1)
            {
                param1.scaleX = 1;
                param1.scaleY = 1;
                param1.x = int(param2.x + param2.width / 2);
                param1.y = int(param2.y);
            }
            else if (param3 == 2)
            {
                param1.scaleX = -1;
                param1.scaleY = 1;
                param1.x = int(param2.x + param2.width);
                param1.y = int(param2.y);
            }
            else if (param3 == 3)
            {
                param1.scaleX = 1;
                param1.scaleY = 1;
                param1.x = int(param2.x);
                param1.y = int(param2.y + param2.height / 2);
            }
            else if (param3 == 4)
            {
                param1.scaleX = 1;
                param1.scaleY = 1;
                param1.x = int(param2.x + param2.width / 2);
                param1.y = int(param2.y + param2.height / 2);
            }
            else if (param3 == 5)
            {
                param1.scaleX = -1;
                param1.scaleY = 1;
                param1.x = int(param2.x + param2.width);
                param1.y = int(param2.y + param2.height / 2);
            }
            else if (param3 == 6)
            {
                param1.scaleX = 1;
                param1.scaleY = -1;
                param1.x = int(param2.x);
                param1.y = int(param2.y + param2.height);
            }
            else if (param3 == 7)
            {
                param1.scaleX = 1;
                param1.scaleY = -1;
                param1.x = int(param2.x + param2.width / 2);
                param1.y = int(param2.y + param2.height);
            }
            else if (param3 == 8)
            {
                param1.scaleY = -1;
                param1.scaleX = -1;
                param1.x = int(param2.x + param2.width);
                param1.y = int(param2.y + param2.height);
            }
            else
            {
                param1.scaleX = 1;
                param1.scaleY = 1;
                param1.x = int(param2.x);
                param1.y = int(param2.y);
            }
            return;
        }// end function

    }
}
