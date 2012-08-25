// Action script...

// [Initial MovieClip Action of sprite 20965]
#initclip 230
if (!dofus.graphics.gapi.controls.DeathCounter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.DeathCounter = function ()
    {
        super();
    }).prototype;
    _loc1.__set__death = function (nDeath)
    {
        this._nDeath = nDeath;
        this.draw();
        //return (this.death());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.DeathCounter.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.draw});
    };
    _loc1.draw = function ()
    {
        if (this._nDeath == undefined || this._nDeath == 0)
        {
            return;
        } // end if
        var _loc2 = this._nDeath > dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD ? (dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD) : (this._nDeath);
        var _loc3 = Math.PI / _loc2;
        var _loc4 = -_loc3 / 2;
        var _loc5 = this._mcPlacer._width / 2;
        var _loc6 = this._mcPlacer._height;
        var _loc7 = this._mcPlacer._width / 2;
        var _loc8 = this._mcPlacer._height;
        var _loc9 = this.createEmptyMovieClip("_mcHeads", 100);
        _loc9._x = this._mcPlacer._x;
        _loc9._y = this._mcPlacer._y;
        var _loc10 = 0;
        
        while (++_loc10, _loc10 < _loc2)
        {
            var _loc11 = _loc4 - _loc10 * _loc3;
            var _loc12 = Math.cos(_loc11) * _loc5 + _loc7;
            var _loc13 = Math.sin(_loc11) * _loc6 + _loc8;
            if (_loc10 == 0 && this._nDeath > dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD)
            {
                var _loc14 = "_mcDeathCounterHeadMore";
            }
            else
            {
                _loc14 = "_mcDeathCounterHead";
            } // end else if
            _loc9.attachMovie(_loc14, "head" + _loc10, _loc10, {_x: _loc12, _y: _loc13, _rotation: _loc11 * 180 / Math.PI});
        } // end while
    };
    _loc1.addProperty("death", function ()
    {
    }, _loc1.__set__death);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.DeathCounter = function ()
    {
        super();
    }).CLASS_NAME = "DeathCounter";
    (_global.dofus.graphics.gapi.controls.DeathCounter = function ()
    {
        super();
    }).MAX_HEAD = 11;
} // end if
#endinitclip
