// Action script...

// [Initial MovieClip Action of sprite 20817]
#initclip 82
if (!ank.gapi.controls.Fps)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.Fps = function ()
    {
        super();
    }).prototype;
    _loc1.__set__averageOffset = function (nAverageOffset)
    {
        this._nAverageOffset = nAverageOffset;
        //return (this.averageOffset());
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Fps.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcBack", this.getNextHighestDepth());
        this.drawRoundRect(this._mcBack, 0, 0, 1, 1, 0, 16777215);
        this.attachMovie("Label", "_lblText", this.getNextHighestDepth(), {text: "--"});
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._mcBack._width = this.__width;
        this._mcBack._height = this.__height;
        this._lblText.setSize(this.__width, this.__height);
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        if (_loc2.backcolor != undefined)
        {
            this.setMovieClipColor(this._mcBack, _loc2.backcolor);
        } // end if
        this._mcBack._alpha = _loc2.backalpha;
        this._lblText.styleName = _loc2.labelstyle;
    };
    _loc1.pushValue = function (nValue)
    {
        this._aValues.push(nValue);
        if (this._aValues.length > this._nAverageOffset)
        {
            this._aValues.shift();
        } // end if
    };
    _loc1.getAverage = function ()
    {
        var _loc2 = 0;
        for (var k in this._aValues)
        {
            _loc2 = _loc2 + Number(this._aValues[k]);
        } // end of for...in
        return (Math.round(_loc2 / this._aValues.length));
    };
    _loc1.onEnterFrame = function ()
    {
        var _loc2 = getTimer();
        var _loc3 = _loc2 - this._nSaveTime;
        this.pushValue(1 / (_loc3 / 1000));
        this._lblText.text = String(this.getAverage());
        this._nSaveTime = _loc2;
    };
    _loc1.addProperty("averageOffset", function ()
    {
    }, _loc1.__set__averageOffset);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Fps = function ()
    {
        super();
    }).CLASS_NAME = "Fps";
    _loc1._nAverageOffset = 10;
    _loc1._aValues = new Array();
} // end if
#endinitclip
