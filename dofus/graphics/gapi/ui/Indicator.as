// Action script...

// [Initial MovieClip Action of sprite 20911]
#initclip 176
if (!dofus.graphics.gapi.ui.Indicator)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Indicator = function ()
    {
        super();
    }).prototype;
    _loc1.__set__rotate = function (bRotate)
    {
        this._bRotate = bRotate;
        //return (this.rotate());
    };
    _loc1.__set__coordinates = function (aCoordinates)
    {
        this._aCoordinates = aCoordinates;
        //return (this.coordinates());
    };
    _loc1.__set__offset = function (nOffset)
    {
        this._nOffset = nOffset;
        //return (this.offset());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Indicator.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        var _loc2 = this._aCoordinates[0];
        var _loc3 = this._aCoordinates[1];
        if (this._bRotate)
        {
            var _loc5 = this.gapi.screenWidth / 2;
            var _loc6 = this.gapi.screenHeight / 2;
            var _loc7 = Math.atan2(this._aCoordinates[1] - _loc6, this._aCoordinates[0] - _loc5);
            var _loc4 = _loc7 * 180 / Math.PI - 90;
            _loc2 = _loc2 - (this._nOffset == undefined ? (0) : (this._nOffset * Math.cos(_loc7)));
            _loc3 = _loc3 - (this._nOffset == undefined ? (0) : (this._nOffset * Math.sin(_loc7)));
        }
        else
        {
            _loc3 = _loc3 - (this._nOffset == undefined ? (0) : (this._nOffset));
        } // end else if
        this.attachMovie("UI_Indicatorlight", "_mcLight", 10, {_x: _loc2, _y: _loc3});
        this.attachMovie("UI_IndicatorArrow", "_mcArrowShadow", 20, {_x: _loc2 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET, _y: _loc3 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET});
        this.attachMovie("UI_IndicatorArrow", "_mcArrow", 30, {_x: _loc2, _y: _loc3});
        var _loc8 = new Color(this._mcArrowShadow);
        _loc8.setTransform(dofus.graphics.gapi.ui.Indicator.SHADOW_TRANSFORM);
        if (this._bRotate)
        {
            this._mcLight._rotation = _loc4;
            this._mcArrow._rotation = _loc4;
            this._mcArrowShadow._rotation = _loc4;
        } // end if
    };
    _loc1.addProperty("rotate", function ()
    {
    }, _loc1.__set__rotate);
    _loc1.addProperty("offset", function ()
    {
    }, _loc1.__set__offset);
    _loc1.addProperty("coordinates", function ()
    {
    }, _loc1.__set__coordinates);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Indicator = function ()
    {
        super();
    }).CLASS_NAME = "Indicator";
    (_global.dofus.graphics.gapi.ui.Indicator = function ()
    {
        super();
    }).SHADOW_OFFSET = 3;
    (_global.dofus.graphics.gapi.ui.Indicator = function ()
    {
        super();
    }).SHADOW_TRANSFORM = {ra: 0, rb: 0, ga: 0, gb: 0, ba: 0, bb: 0, aa: 40, ab: 0};
    _loc1._bRotate = true;
    _loc1._nOffset = 0;
} // end if
#endinitclip
