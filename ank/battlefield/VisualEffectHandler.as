// Action script...

// [Initial MovieClip Action of sprite 863]
#initclip 75
class ank.battlefield.VisualEffectHandler
{
    var _mcBattlefield, _mcContainer, _incIndex, attachMovie, shoot, end, onEnterFrame, move;
    function VisualEffectHandler(b, c)
    {
        this.initialize(b, c);
    } // End of the function
    function initialize(b, c)
    {
        _mcBattlefield = b;
        _mcContainer = c;
        this.clear();
    } // End of the function
    function clear(Void)
    {
        _incIndex = 0;
    } // End of the function
    function addEffect(sprite, oVisualEffect, nCellNum, displayType)
    {
        if (displayType < 10)
        {
            return;
        } // end if
        var _loc7 = oVisualEffect.bInFrontOfSprite ? (1) : (-1);
        var _loc3 = this.getNextIndex() + ank.battlefield.Constants.MAX_SPRITES_ON_CELL / 2 + 1;
        _mcContainer["eff" + _loc3].removeMovieClip();
        _mcContainer.createEmptyMovieClip("eff" + _loc3, nCellNum * 100 + 50 + _loc7 * _loc3);
        var _loc2 = _mcContainer["eff" + _loc3];
        _loc2.createEmptyMovieClip("mc", 10);
        var _loc5 = new MovieClipLoader();
        _loc5.addListener(this);
        _loc2.sprite = sprite;
        _loc2.cellNum = nCellNum;
        _loc2.displayType = displayType;
        _loc2.level = oVisualEffect.level;
        _loc2.params = oVisualEffect.params;
        if (oVisualEffect.bTryToBypassContainerColor == true)
        {
            var _loc6 = new Color(_loc2);
            _loc6.setTransform({ra: 200, rb: 0, ga: 200, gb: 0, ba: 200, bb: 0});
        } // end if
        _loc5.loadClip(oVisualEffect.file, _loc2.mc);
        ank.utils.Timer.setTimer(_loc2, "battlefield", _loc2, _loc2.removeMovieClip, ank.battlefield.Constants.VISUAL_EFFECT_MAX_TIMER);
    } // End of the function
    function onLoadInit(mc)
    {
        var _loc9 = mc._parent.sprite;
        var _loc16 = mc._parent.cellNum;
        var displayType = mc._parent.displayType;
        var _loc7 = mc._parent.level;
        var _loc15 = mc._parent.params;
        var _loc17 = _loc9.__get__cellNum();
        var _loc3 = _mcBattlefield.mapHandler.getCellData(_loc17);
        var _loc4 = _mcBattlefield.mapHandler.getCellData(_loc16);
        mc._ACTION = _loc9;
        mc.level = _loc7;
        mc.angle = Math.atan2(_loc4.y - _loc3.y, _loc4.x - _loc3.x) * 180 / 3.141593E+000;
        mc.params = _loc15;
        switch (displayType)
        {
            case 10:
            case 12:
            {
                mc._x = _loc3.x;
                mc._y = _loc3.y;
                break;
            } 
            case 11:
            {
                mc._x = _loc4.x;
                mc._y = _loc4.y;
                break;
            } 
            case 20:
            case 21:
            {
                mc._x = _loc3.x;
                mc._y = _loc3.y;
                var _loc8 = 1.570796E+000;
                var _loc5 = _loc4.x - _loc3.x;
                var _loc6 = _loc4.y - _loc3.y;
                mc.rotate._rotation = mc.angle;
                var _loc10 = mc.attachMovie("shoot", "shoot", 10);
                _loc10._x = _loc5;
                _loc10._y = _loc6;
                break;
            } 
            case 30:
            case 31:
            {
                mc._x = _loc3.x;
                mc._y = _loc3.y - 10;
                mc.level = _loc7;
                var _loc13 = displayType == 31 || displayType == 33 ? (9.000000E-001) : (5.000000E-001);
                var speed = displayType == 31 || displayType == 33 ? (4.000000E-001) : (5.000000E-001);
                _loc8 = 1.570796E+000;
                _loc5 = _loc4.x - _loc3.x;
                _loc6 = _loc4.y - _loc3.y;
                var _loc14 = (Math.atan2(_loc6, Math.abs(_loc5)) + _loc8) * _loc13;
                var _loc11 = _loc14 - _loc8;
                var xDest = Math.abs(_loc5);
                var yDest = _loc6;
                if (_loc5 <= 0)
                {
                    if (_loc5 == 0 && _loc6 < 0)
                    {
                        mc._yscale = -mc._yscale;
                        yDest = -yDest;
                    } // end if
                    mc._xscale = -mc._xscale;
                } // end if
                mc.attachMovie("move", "move", 2);
                var vyi;
                var x;
                var y;
                var g = 9.810000E+000;
                var halfg = g / 2;
                var t = 0;
                var vx = Math.sqrt(Math.abs(halfg * Math.pow(xDest, 2) / Math.abs(yDest - Math.tan(_loc11) * xDest)));
                var vy = Math.tan(_loc11) * vx;
                mc.onEnterFrame = function ()
                {
                    vyi = vy + g * t;
                    x = t * vx;
                    y = halfg * Math.pow(t, 2) + vy * t;
                    t = t + speed;
                    if (Math.abs(y) >= Math.abs(yDest) && x >= xDest || x > xDest)
                    {
                        this.attachMovie("shoot", "shoot", 2);
                        shoot._x = xDest;
                        shoot._y = yDest;
                        shoot._rotation = Math.atan(vyi / vx) * 180 / 3.141593E+000;
                        this.end();
                        delete this.onEnterFrame;
                    }
                    else
                    {
                        move._x = x;
                        move._y = y;
                        move._rotation = Math.atan(vyi / vx) * 180 / 3.141593E+000;
                    } // end else if
                };
                break;
            } 
            case 40:
            case 41:
            {
                mc._x = _loc3.x;
                mc._y = _loc3.y;
                var speed = 20;
                var xStart = _loc3.x;
                var yStart = _loc3.y;
                var xDest = _loc4.x;
                var yDest = _loc4.y;
                var rot = Math.atan2(yDest - yStart, xDest - xStart);
                var fullDist = Math.sqrt(Math.pow(xStart - xDest, 2) + Math.pow(yStart - yDest, 2));
                var interval = fullDist / Math.floor(fullDist / speed);
                var dist = 0;
                var inc = 1;
                mc.onEnterFrame = function ()
                {
                    dist = dist + interval;
                    if (dist > fullDist)
                    {
                        this.end();
                        if (displayType == 41)
                        {
                            this.attachMovie("shoot", "shoot", 10);
                            shoot._x = xDest - xStart;
                            shoot._y = yDest - yStart;
                        } // end if
                        delete this.onEnterFrame;
                    }
                    else
                    {
                        var _loc2 = this.attachMovie("duplicate", "duplicate" + inc, inc);
                        _loc2._x = dist * Math.cos(rot);
                        _loc2._y = dist * Math.sin(rot);
                        ++inc;
                    } // end else if
                };
                break;
            } 
            case 50:
            case 51:
            {
                mc.cellFrom = {x: _loc3.x, y: _loc3.y};
                mc.cellTo = {x: _loc4.x, y: _loc4.y};
                break;
            } 
        } // End of switch
    } // End of the function
    function getNextIndex(Void)
    {
        ++_incIndex;
        if (_incIndex > ank.battlefield.VisualEffectHandler.MAX_INDEX)
        {
            _incIndex = 0;
        } // end if
        return (_incIndex);
    } // End of the function
    static var MAX_INDEX = 21;
} // End of Class
#endinitclip
