// Action script...

// [Initial MovieClip Action of sprite 1020]
#initclip 241
class dofus.graphics.gapi.controls.ArtworkRotation extends ank.gapi.core.UIBasicComponent
{
    var _ariMan, _ariWoman, __get__classID, _i, _nCurrentSex, _di, __set__classID;
    function ArtworkRotation()
    {
        super();
    } // End of the function
    function set classID(nClassID)
    {
        _ariMan.loadArtwork(nClassID);
        _ariWoman.loadArtwork(nClassID);
        //return (this.classID());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ArtworkRotation.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _i = 2.020000E+000;
    } // End of the function
    function setPosition(nSex)
    {
        if (_nCurrentSex == nSex)
        {
            return;
        } // end if
        _nCurrentSex = nSex;
        var _loc2 = nSex == 0;
        _ariWoman.colorize(_loc2);
        _ariMan.colorize(!_loc2);
        if (!_loc2)
        {
            _ariMan.swapDepths(_ariWoman);
        } // end if
        _i = _loc2 ? (2) : (5.130000E+000);
        var _loc3 = -3.040000E+001 * (_loc2 ? (-1) : (1));
        var _loc5 = 2.870000E+001 * (_loc2 ? (-1) : (1));
        var _loc4 = -4.560000E+001 * (_loc2 ? (-1) : (1));
        _ariMan._x = _loc5;
        _ariMan._y = _loc4;
        _ariWoman._x = -_loc5;
        _ariWoman._y = -_loc4;
        _ariMan._xscale = 100 + _loc3;
        _ariMan._yscale = 100 + _loc3;
        _ariWoman._xscale = 100 - _loc3;
        _ariWoman._yscale = 100 - _loc3;
    } // End of the function
    function rotate(nSex)
    {
        if (_nCurrentSex == nSex)
        {
            return;
        } // end if
        _nCurrentSex = nSex;
        var piy = 0;
        var px = 0;
        var py = 0;
        var t = 0;
        var bSwaped = false;
        var _loc2 = nSex == 0;
        _ariWoman.colorize(_loc2);
        _ariMan.colorize(!_loc2);
        _di = _loc2 ? (2) : (5.141593E+000);
        function onEnterFrame()
        {
            if (Math.abs(_i - _di) > 1.000000E-002)
            {
                _i = _i - (_i - _di) / 3;
                piy = py;
                px = 70 * Math.cos(_i);
                py = 50 * Math.sin(_i);
                if (piy < 0 && py >= 0 || piy >= 0 && py < 0)
                {
                    if (!bSwaped)
                    {
                        _ariMan.swapDepths(_ariWoman);
                        bSwaped = true;
                    } // end if
                } // end if
                t = py / 1.500000E+000;
                _ariMan._x = px;
                _ariMan._y = py;
                _ariWoman._x = -px;
                _ariWoman._y = -py;
                _ariMan._xscale = 100 + t;
                _ariMan._yscale = 100 + t;
                _ariWoman._xscale = 100 - t;
                _ariWoman._yscale = 100 - t;
            }
            else
            {
                delete this.onEnterFrame;
            } // end else if
        } // End of the function
    } // End of the function
    static var CLASS_NAME = "ArtworkRotationItem";
} // End of Class
#endinitclip
