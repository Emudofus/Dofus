// Action script...

// [Initial MovieClip Action of sprite 20764]
#initclip 29
if (!dofus.graphics.battlefield.FightOptionsOverHead)
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
    var _loc1 = (_global.dofus.graphics.battlefield.FightOptionsOverHead = function (tTeam)
    {
        super();
        this.initialize(tTeam);
        this.draw();
    }).prototype;
    _loc1.__get__height = function ()
    {
        return (20);
    };
    _loc1.initialize = function (tTeam)
    {
        this._mc.removeMovieClip();
        this.createEmptyMovieClip("_mc", 10);
        this._tTeam = tTeam;
    };
    _loc1.draw = function ()
    {
        for (var a in this._mc)
        {
            this._mc[a].removeMovieClip();
        } // end of for...in
        var _loc2 = 0;
        for (var a in this._tTeam.options)
        {
            var _loc3 = this._tTeam.options[a];
            if (_loc3 == true)
            {
                var _loc4 = this._mc.attachMovie("UI_FightOption" + a + "Up", "mcOption" + _loc2, _loc2);
                _loc4._x = _loc2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH;
                _loc4.onEnterFrame = function ()
                {
                    this.play();
                    delete this.onEnterFrame;
                };
                ++_loc2;
            } // end if
        } // end of for...in
        this._x = -_loc2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH / 2;
    };
    _loc1.addProperty("height", _loc1.__get__height, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.battlefield.FightOptionsOverHead = function (tTeam)
    {
        super();
        this.initialize(tTeam);
        this.draw();
    }).ICON_WIDTH = 20;
} // end if
#endinitclip
