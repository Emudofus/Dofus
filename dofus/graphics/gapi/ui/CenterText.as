// Action script...

// [Initial MovieClip Action of sprite 20486]
#initclip 7
if (!dofus.graphics.gapi.ui.CenterText)
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
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.CenterText = function ()
    {
        super();
    }).prototype;
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        //return (this.text());
    };
    _loc1.__set__background = function (bBackground)
    {
        this._bBackground = bBackground;
        //return (this.background());
    };
    _loc1.__set__timer = function (nTimer)
    {
        this._nTimer = nTimer;
        //return (this.timer());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.CenterText.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        if (this._sText.length == 0)
        {
            return;
        } // end if
        this.addToQueue({object: this, method: this.initText});
        this._mcBackground._visible = false;
        this._prgbGfxLoad._visible = false;
        if (this._nTimer != 0)
        {
            ank.utils.Timer.setTimer(this, "centertext", this, this.unloadThis, this._nTimer);
        } // end if
    };
    _loc1.initText = function ()
    {
        this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this._sText;
        var _loc2 = this._lblWhite.textHeight;
        this._mcBackground._visible = this._bBackground;
        this._mcBackground._height = _loc2 + 2.500000E+000 * (this._lblWhite._y - this._mcBackground._y);
    };
    _loc1.updateProgressBar = function (sLabel, nCurrentVal, nMaxVal)
    {
        var _loc5 = Math.floor(nCurrentVal / nMaxVal * 100);
        if (_global.isNaN(_loc5))
        {
            _loc5 = 0;
        } // end if
        this._prgbGfxLoad._visible = true;
        this._prgbGfxLoad.txtInfo.text = sLabel;
        this._prgbGfxLoad.txtPercent.text = _loc5 + "%";
        this._prgbGfxLoad.mcProgressBar._width = _loc5;
    };
    _loc1.addProperty("timer", function ()
    {
    }, _loc1.__set__timer);
    _loc1.addProperty("background", function ()
    {
    }, _loc1.__set__background);
    _loc1.addProperty("text", function ()
    {
    }, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.CenterText = function ()
    {
        super();
    }).CLASS_NAME = "CenterText";
    _loc1._sText = "";
    _loc1._bBackground = false;
    _loc1._nTimer = 0;
} // end if
#endinitclip
