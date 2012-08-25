// Action script...

// [Initial MovieClip Action of sprite 20987]
#initclip 252
if (!ank.battlefield.mc.BubbleThink)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.BubbleThink = function (text, x, y, maxW)
    {
        super(text, x, y, maxW);
    }).prototype;
    _loc1.drawCircle = function (mc, x, y, ray, color)
    {
        var _loc7 = x + Math.sin(360 / 15 * 0 * Math.PI / 180) * ray;
        var _loc8 = y + Math.cos(360 / 15 * 0 * Math.PI / 180) * ray;
        mc.moveTo(_loc7, _loc8);
        mc.beginFill(color, 100);
        var _loc9 = 0;
        
        while (++_loc9, _loc9 <= 15)
        {
            var _loc10 = x + Math.sin(360 / 15 * _loc9 * Math.PI / 180) * ray;
            var _loc11 = y + Math.cos(360 / 15 * _loc9 * Math.PI / 180) * ray;
            mc.lineTo(_loc10, _loc11);
        } // end while
        mc.endFill();
    };
    _loc1.drawBackground = function (w, h)
    {
        var _loc4 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
        this.createEmptyMovieClip("_bg", 10);
        var _loc5 = -h - _loc4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
        var _loc6 = -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
        var _loc7 = 0;
        var _loc8 = w + _loc4;
        this._bg.moveTo(_loc7, _loc5);
        this._bg.lineStyle(0, 16777215);
        this._bg.beginFill(16777215, 100);
        this._bg.lineTo(_loc8, _loc5);
        this._bg.lineTo(_loc8, _loc6);
        this._bg.lineTo(_loc7, _loc6);
        this._bg.lineTo(_loc7, _loc5);
        this._bg.endFill();
        var _loc9 = _loc7;
        
        while (_loc9 = _loc9 + 14, _loc9 <= _loc8)
        {
            this.drawCircle(this._bg, _loc9, _loc5, 7, 16777215);
        } // end while
        var _loc10 = _loc7;
        
        while (_loc10 = _loc10 + 14, _loc10 <= _loc8)
        {
            this.drawCircle(this._bg, _loc10, _loc6, 7, 16777215);
        } // end while
        var _loc11 = _loc5;
        
        while (_loc11 = _loc11 + 14, _loc11 <= _loc6)
        {
            this.drawCircle(this._bg, _loc8, _loc11, 7, 16777215);
        } // end while
        var _loc12 = _loc5;
        
        while (_loc12 = _loc12 + 14, _loc12 <= _loc6)
        {
            this.drawCircle(this._bg, _loc7, _loc12, 7, 16777215);
        } // end while
        this.drawCircle(this._bg, _loc7, _loc6 + 5, 8, 16777215);
        this.drawCircle(this._bg, -5, 5, 4, 16777215);
        var _loc13 = new Array();
        _loc13.push(new flash.filters.GlowFilter(0, 30, 2, 2, 3, 3, false, false));
        this._bg.filters = _loc13;
        this._bg._alpha = 90;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
