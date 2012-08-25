// Action script...

// [Initial MovieClip Action of sprite 20842]
#initclip 107
if (!dofus.graphics.gapi.controls.PointsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.PointsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__background = function (sBackground)
    {
        this._sBackgroundLink = sBackground;
        //return (this.background());
    };
    _loc1.__set__textColor = function (nTextColor)
    {
        this._nTextColor = nTextColor;
        //return (this.textColor());
    };
    _loc1.__set__value = function (nValue)
    {
        nValue = Number(nValue);
        if (_global.isNaN(nValue))
        {
            return;
        } // end if
        this._nValue = nValue;
        this.applyValue();
        this.useHandCursor = false;
        //return (this.value());
    };
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.PointsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie(this._sBackgroundLink, "_mcBg", this._txtValue.getDepth() - 1);
        this._txtValue.textColor = this._nTextColor;
    };
    _loc1.applyValue = function ()
    {
        this._txtValue.text = String(this._nValue);
    };
    _loc1.onRollOver = function ()
    {
        this.dispatchEvent({type: "over"});
    };
    _loc1.onRollOut = function ()
    {
        this.dispatchEvent({type: "out"});
    };
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    _loc1.addProperty("textColor", function ()
    {
    }, _loc1.__set__textColor);
    _loc1.addProperty("background", function ()
    {
    }, _loc1.__set__background);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.PointsViewer = function ()
    {
        super();
    }).CLASS_NAME = "PointsViewer";
} // end if
#endinitclip
