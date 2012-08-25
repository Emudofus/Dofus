// Action script...

// [Initial MovieClip Action of sprite 20931]
#initclip 196
if (!ank.battlefield.mc.InteractiveObject)
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
    var _loc1 = (_global.ank.battlefield.mc.InteractiveObject = function ()
    {
        super();
    }).prototype;
    _loc1.initialize = function (b, oCell, bInteractive)
    {
        this._battlefield = b;
        this._oCell = oCell;
        this._bInteractive = bInteractive == undefined ? (true) : (bInteractive);
    };
    _loc1.select = function (bool)
    {
        var _loc3 = new Color(this);
        var _loc4 = new Object();
        if (bool)
        {
            _loc4 = {ra: 60, rb: 80, ga: 60, gb: 80, ba: 60, bb: 80};
        }
        else
        {
            _loc4 = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
        } // end else if
        _loc3.setTransform(_loc4);
    };
    _loc1.loadExternalClip = function (sFile, bAutoSize)
    {
        bAutoSize = bAutoSize == undefined ? (true) : (bAutoSize);
        this.createEmptyMovieClip("_mcExternal", 10);
        this._mclLoader = new MovieClipLoader();
        if (bAutoSize)
        {
            this._mclLoader.addListener(this);
        } // end if
        this._mclLoader.loadClip(sFile, this._mcExternal);
    };
    _loc1.__get__cellData = function ()
    {
        return (this._oCell);
    };
    _loc1._release = function (Void)
    {
        if (this._bInteractive)
        {
            this._battlefield.onObjectRelease(this);
        } // end if
    };
    _loc1._rollOver = function (Void)
    {
        if (this._bInteractive)
        {
            this._battlefield.onObjectRollOver(this);
        } // end if
    };
    _loc1._rollOut = function (Void)
    {
        if (this._bInteractive)
        {
            this._battlefield.onObjectRollOut(this);
        } // end if
    };
    _loc1.onLoadInit = function (mc)
    {
        var _loc3 = mc._width;
        var _loc4 = mc._height;
        var _loc5 = _loc3 / _loc4;
        var _loc6 = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
        if (_loc5 == _loc6)
        {
            mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
            mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
        }
        else if (_loc5 > _loc6)
        {
            mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
            mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / _loc5;
        }
        else
        {
            mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE * _loc5;
            mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
        } // end else if
        var _loc7 = mc.getBounds(mc._parent);
        mc._x = -_loc7.xMin - mc._width / 2;
        mc._y = -_loc7.yMin - mc._height;
    };
    _loc1.addProperty("cellData", _loc1.__get__cellData, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
