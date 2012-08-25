// Action script...

// [Initial MovieClip Action of sprite 20899]
#initclip 164
if (!ank.battlefield.VisualEffectHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.VisualEffectHandler = function (b, c)
    {
        this.initialize(b, c);
    }).prototype;
    _loc1.initialize = function (b, c)
    {
        this._mcBattlefield = b;
        this._mcContainer = c;
        this.clear();
    };
    _loc1.clear = function (Void)
    {
        this._incIndex = 0;
    };
    _loc1.addEffect = function (sprite, oVisualEffect, nCellNum, displayType, targetSprite, bVisible)
    {
        if (displayType < 10)
        {
            return;
        } // end if
        var _loc8 = oVisualEffect.bInFrontOfSprite ? (1) : (-1);
        var _loc9 = this.getNextIndex() + ank.battlefield.Constants.MAX_SPRITES_ON_CELL / 2 + 1;
        this._mcContainer["eff" + _loc9].removeMovieClip();
        this._mcContainer.createEmptyMovieClip("eff" + _loc9, nCellNum * 100 + 50 + _loc8 * _loc9);
        var _loc10 = this._mcContainer["eff" + _loc9];
        _loc10.createEmptyMovieClip("mc", 10);
        _loc10._visible = bVisible == undefined ? (true) : (bVisible);
        var _loc11 = new MovieClipLoader();
        _loc11.addListener(this);
        _loc10.sprite = sprite;
        _loc10.targetSprite = targetSprite;
        _loc10.cellNum = nCellNum;
        _loc10.displayType = displayType;
        _loc10.level = oVisualEffect.level;
        _loc10.params = oVisualEffect.params;
        if (oVisualEffect.bTryToBypassContainerColor == true)
        {
            var _loc12 = new Color(_loc10);
            _loc12.setTransform({ra: 200, rb: 0, ga: 200, gb: 0, ba: 200, bb: 0});
        } // end if
        _loc11.loadClip(oVisualEffect.file, _loc10.mc);
        ank.utils.Timer.setTimer(_loc10, "battlefield", _loc10, _loc10.removeMovieClip, ank.battlefield.Constants.VISUAL_EFFECT_MAX_TIMER);
    };
    _loc1.onLoadInit = function (mc)
    {
        var _loc3 = mc._parent.sprite;
        var _loc4 = mc._parent.targetSprite;
        var _loc5 = mc._parent.cellNum;
        var displayType = mc._parent.displayType;
        var _loc6 = mc._parent.level;
        var _loc7 = mc._parent.params;
        var _loc8 = mc._parent.ignoreTargetInHeight;
        var _loc9 = _loc3.cellNum;
        var _loc10 = this._mcBattlefield.mapHandler.getCellData(_loc9);
        var _loc11 = this._mcBattlefield.mapHandler.getCellData(_loc5);
        var _loc12 = !_loc3 ? ({x: _loc10.x, y: _loc10.y}) : ({x: _loc3.mc._x, y: _loc3.mc._y});
        var _loc13 = !_loc4 ? ({x: _loc11.x, y: _loc11.y}) : ({x: _loc4.mc._x, y: _loc4.mc._y});
        mc._ACTION = _loc3;
        mc.level = _loc6;
        mc.angle = Math.atan2(_loc13.y - _loc12.y, _loc13.x - _loc12.x) * 180 / Math.PI;
        mc.params = _loc7;
        switch (displayType)
        {
            case 10:
            case 12:
            {
                mc._x = _loc12.x;
                mc._y = _loc12.y;
                break;
            } 
            case 11:
            {
                mc._x = _loc13.x;
                mc._y = _loc13.y;
                break;
            } 
            case 20:
            case 21:
            {
                mc._x = _loc12.x;
                mc._y = _loc12.y;
                var _loc14 = Math.PI / 2;
                var _loc15 = _loc13.x - _loc12.x;
                var _loc16 = _loc13.y - _loc12.y;
                mc.rotate._rotation = mc.angle;
                var _loc17 = mc.attachMovie("shoot", "shoot", 10);
                _loc17._x = _loc15;
                _loc17._y = _loc16;
                break;
            } 
            case 30:
            case 31:
            {
                mc._x = _loc12.x;
                mc._y = _loc12.y - 10;
                mc.level = _loc6;
                var _loc18 = displayType == 31 || displayType == 33 ? (9.000000E-001) : (5.000000E-001);
                var speed = displayType == 31 || displayType == 33 ? (4.000000E-001) : (5.000000E-001);
                var _loc19 = Math.PI / 2;
                var _loc20 = _loc13.x - _loc12.x;
                var _loc21 = _loc13.y - _loc12.y;
                var _loc22 = (Math.atan2(_loc21, Math.abs(_loc20)) + _loc19) * _loc18;
                var _loc23 = _loc22 - _loc19;
                var xDest = Math.abs(_loc20);
                var yDest = _loc21;
                mc.startangle = _loc23;
                if (_loc20 <= 0)
                {
                    if (_loc20 == 0 && _loc21 < 0)
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
                var vx = Math.sqrt(Math.abs(halfg * Math.pow(xDest, 2) / Math.abs(yDest - Math.tan(_loc23) * xDest)));
                var vy = Math.tan(_loc23) * vx;
                mc.onEnterFrame = function ()
                {
                    vyi = vy + g * t;
                    x = t * vx;
                    y = halfg * Math.pow(t, 2) + vy * t;
                    t = t + speed;
                    if (Math.abs(y) >= Math.abs(yDest) && x >= xDest || x > xDest)
                    {
                        this.attachMovie("shoot", "shoot", 2);
                        this.shoot._x = xDest;
                        this.shoot._y = yDest;
                        this.shoot._rotation = Math.atan(vyi / vx) * 180 / Math.PI;
                        this.end();
                        delete this.onEnterFrame;
                    }
                    else
                    {
                        this.move._x = x;
                        this.move._y = y;
                        this.move._rotation = Math.atan(vyi / vx) * 180 / Math.PI;
                    } // end else if
                };
                break;
            } 
            case 40:
            case 41:
            {
                mc._x = _loc12.x;
                mc._y = _loc12.y;
                var _loc24 = 20;
                var xStart = _loc12.x;
                var yStart = _loc12.y;
                var xDest = _loc13.x;
                var yDest = _loc13.y;
                var rot = Math.atan2(yDest - yStart, xDest - xStart);
                var fullDist = Math.sqrt(Math.pow(xStart - xDest, 2) + Math.pow(yStart - yDest, 2));
                var interval = fullDist / Math.floor(fullDist / _loc24);
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
                            this.shoot._x = xDest - xStart;
                            this.shoot._y = yDest - yStart;
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
                mc.cellFrom = _loc12;
                mc.cellTo = _loc13;
                break;
            } 
        } // End of switch
    };
    _loc1.getNextIndex = function (Void)
    {
        ++this._incIndex;
        if (this._incIndex > ank.battlefield.VisualEffectHandler.MAX_INDEX)
        {
            this._incIndex = 0;
        } // end if
        return (this._incIndex);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.battlefield.VisualEffectHandler = function (b, c)
    {
        this.initialize(b, c);
    }).MAX_INDEX = 21;
} // end if
#endinitclip
