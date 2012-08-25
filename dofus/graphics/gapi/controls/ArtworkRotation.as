// Action script...

// [Initial MovieClip Action of sprite 20684]
#initclip 205
if (!dofus.graphics.gapi.controls.ArtworkRotation)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ArtworkRotation = function ()
    {
        super();
    }).prototype;
    _loc1.__set__classID = function (nClassID)
    {
        this._ariMan.loadArtwork(nClassID);
        this._ariWoman.loadArtwork(nClassID);
        //return (this.classID());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ArtworkRotation.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._i = 2.020000E+000;
    };
    _loc1.setPosition = function (nSex)
    {
        if (this._nCurrentSex == nSex)
        {
            return;
        } // end if
        this._nCurrentSex = nSex;
        var _loc3 = nSex == 0;
        this._ariWoman.colorize(_loc3);
        this._ariMan.colorize(!_loc3);
        if (!_loc3)
        {
            this._ariMan.swapDepths(this._ariWoman);
        } // end if
        this._i = _loc3 ? (2) : (5.130000E+000);
        var _loc4 = -3.040000E+001 * (_loc3 ? (-1) : (1));
        var _loc5 = 2.870000E+001 * (_loc3 ? (-1) : (1));
        var _loc6 = -4.560000E+001 * (_loc3 ? (-1) : (1));
        this._ariMan._x = _loc5;
        this._ariMan._y = _loc6;
        this._ariWoman._x = -_loc5;
        this._ariWoman._y = -_loc6;
        this._ariMan._xscale = 100 + _loc4;
        this._ariMan._yscale = 100 + _loc4;
        this._ariWoman._xscale = 100 - _loc4;
        this._ariWoman._yscale = 100 - _loc4;
    };
    _loc1.rotate = function (nSex)
    {
        if (this._nCurrentSex == nSex)
        {
            return;
        } // end if
        this._nCurrentSex = nSex;
        var piy = 0;
        var px = 0;
        var py = 0;
        var t = 0;
        var bSwaped = false;
        var _loc3 = nSex == 0;
        this._ariWoman.colorize(_loc3);
        this._ariMan.colorize(!_loc3);
        this._di = _loc3 ? (2) : (2 + Math.PI);
        this.onEnterFrame = function ()
        {
            if (Math.abs(this._i - this._di) > 1.000000E-002)
            {
                this._i = this._i - (this._i - this._di) / 3;
                piy = py;
                px = 70 * Math.cos(this._i);
                py = 50 * Math.sin(this._i);
                if (piy < 0 && py >= 0 || piy >= 0 && py < 0)
                {
                    if (!bSwaped)
                    {
                        this._ariMan.swapDepths(this._ariWoman);
                        bSwaped = true;
                    } // end if
                } // end if
                t = py / 1.500000E+000;
                this._ariMan._x = px;
                this._ariMan._y = py;
                this._ariWoman._x = -px;
                this._ariWoman._y = -py;
                this._ariMan._xscale = 100 + t;
                this._ariMan._yscale = 100 + t;
                this._ariWoman._xscale = 100 - t;
                this._ariWoman._yscale = 100 - t;
            }
            else
            {
                delete this.onEnterFrame;
            } // end else if
        };
    };
    _loc1.addProperty("classID", function ()
    {
    }, _loc1.__set__classID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ArtworkRotation = function ()
    {
        super();
    }).CLASS_NAME = "ArtworkRotationItem";
} // end if
#endinitclip
