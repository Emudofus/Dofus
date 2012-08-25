// Action script...

// [Initial MovieClip Action of sprite 20512]
#initclip 33
if (!dofus.managers.EffectsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.EffectsManager = function (oSprite, oAPI)
    {
        super();
        var _loc5 = new flash.display.BitmapData();
        this.initialize(oSprite, oAPI);
    }).prototype;
    _loc1.initialize = function (oSprite, oAPI)
    {
        super.initialize(oAPI);
        this._oSprite = oSprite;
        this._aEffects = new Array();
    };
    _loc1.getEffects = function ()
    {
        return (this._aEffects);
    };
    _loc1.addEffect = function (oEffect)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aEffects.length)
        {
            var _loc4 = this._aEffects[_loc3];
            if (_loc4.spellID == oEffect.spellID && (_loc4.type == oEffect.type && _loc4.remainingTurn == oEffect.remainingTurn))
            {
                _loc4.param1 = _loc4.param1 + oEffect.param1;
                return;
            } // end if
        } // end while
        this._aEffects.push(oEffect);
    };
    _loc1.terminateAllEffects = function ()
    {
        var _loc2 = this._aEffects.length;
        while (--_loc2 >= 0)
        {
            var _loc3 = this._aEffects[_loc2];
            this._aEffects.splice(_loc2, _loc2 + 1);
        } // end while
    };
    _loc1.nextTurn = function ()
    {
        var _loc2 = this._aEffects.length;
        while (--_loc2 >= 0)
        {
            var _loc3 = this._aEffects[_loc2];
            --_loc3.remainingTurn;
            if (_loc3.remainingTurn <= 0)
            {
                this._aEffects.splice(_loc2, 1);
            } // end if
        } // end while
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
