// Action script...

// [Initial MovieClip Action of sprite 20726]
#initclip 247
if (!dofus.graphics.battlefield.EffectsOverHead)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.battlefield)
    {
        _global.dofus.graphics.battlefield = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.battlefield.EffectsOverHead = function (aEffects)
    {
        super();
        this.initialize(aEffects);
        this.draw();
    }).prototype;
    _loc1.__get__height = function ()
    {
        return (20);
    };
    _loc1.initialize = function (aEffects)
    {
        this.createEmptyMovieClip("_mcEffects", 10);
        this._aEffects = aEffects;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this._aEffects.length - 1;
        this._aEffectsQty = new Array();
        while (_loc2 >= 0)
        {
            var _loc3 = this._aEffects[_loc2];
            if (this._aEffectsQty[_loc3.type])
            {
                ++this._aEffectsQty[_loc3.type].qty;
            }
            else
            {
                this._aEffectsQty[_loc3.type] = {effect: _loc3, qty: 1};
            } // end else if
            --_loc2;
        } // end while
        var _loc5 = 0;
        var _loc6 = 0;
        for (var j in this._aEffectsQty)
        {
            _loc3 = this._aEffectsQty[j].effect;
            var _loc7 = new MovieClipLoader();
            _loc7.addListener(this);
            this._mcEffects.createEmptyMovieClip("_mcEffect" + j, Number(j));
            var _loc4 = this._mcEffects["_mcEffect" + j];
            _loc4._x = _loc5;
            _loc5 = _loc5 + dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH;
            _loc4.effect = _loc3;
            _loc7.loadClip(dofus.Constants.EFFECTSICON_FILE, _loc4);
        } // end of for...in
        this._x = -_loc5 / 2;
    };
    _loc1.onLoadInit = function (mc)
    {
        var _loc3 = mc.getDepth();
        var _loc4 = this._aEffectsQty[_loc3].effect;
        var _loc5 = mc.attachMovie("Icon_" + _loc4.characteristic, "icon_mc", 10);
        _loc5.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
        var _loc6 = (dofus.graphics.battlefield.EffectIcon)(_loc5);
        _loc6.initialize(_loc4.operator, this._aEffectsQty[_loc3].qty);
        if (this._aEffectsQty[_loc3].qty > 1)
        {
            _loc5 = mc.attachMovie("Icon_" + _loc4.characteristic, "icon_mc_multiple", 5, {_x: 3, _y: 3});
            _loc5.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
            _loc6 = (dofus.graphics.battlefield.EffectIcon)(_loc5);
            _loc6.initialize(_loc4.operator, this._aEffectsQty[_loc3].qty);
        } // end if
    };
    _loc1.addProperty("height", _loc1.__get__height, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.battlefield.EffectsOverHead = function (aEffects)
    {
        super();
        this.initialize(aEffects);
        this.draw();
    }).ICON_WIDTH = 20;
} // end if
#endinitclip
