// Action script...

// [Initial MovieClip Action of sprite 20730]
#initclip 251
if (!ank.gapi.controls.ToolTip)
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
    var _loc1 = (_global.ank.gapi.controls.ToolTip = function ()
    {
        super();
    }).prototype;
    _loc1.__set__params = function (oParams)
    {
        this._oParams = oParams;
        //return (this.params());
    };
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        if (this.initialized)
        {
            this.layoutContent();
        } // end if
        //return (this.text());
    };
    _loc1.__set__x = function (nX)
    {
        this._nX = nX;
        if (this.initialized)
        {
            this.placeToolTip();
        } // end if
        //return (this.x());
    };
    _loc1.__set__y = function (nY)
    {
        this._nY = nY;
        if (this.initialized)
        {
            this.placeToolTip();
        } // end if
        //return (this.y());
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ToolTip.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._visible = false;
        this.createEmptyMovieClip("_mcBackground", 10);
        this.createTextField("_tfText", 20, 0, 0, ank.gapi.controls.ToolTip.MAX_WIDTH, 100);
        this._tfText.wordWrap = true;
        this._tfText.selectable = false;
        this._tfText.autoSize = "left";
        this._tfText.multiline = true;
        this._tfText.html = true;
        this.addToQueue({object: this, method: this.layoutContent});
        this.addToQueue({object: this, method: this.placeToolTip});
        Key.addListener(this);
    };
    _loc1.placeToolTip = function ()
    {
        var _loc2 = this._oParams.bXLimit || this._oParams.bXLimit == undefined ? (this.gapi.screenWidth) : (Number.MAX_VALUE);
        var _loc3 = this._oParams.bYLimit || this._oParams.bYLimit == undefined ? (this.gapi.screenHeight) : (Number.MAX_VALUE);
        var _loc4 = !this._oParams.bRightAlign || this._oParams.bRightAlign == undefined ? (false) : (this._oParams.bRightAlign);
        var _loc5 = !this._oParams.bTopAlign || this._oParams.bTopAlign == undefined ? (false) : (this._oParams.bTopAlign);
        var _loc6 = _loc4 ? (this._nX - this.__width) : (this._nX);
        var _loc7 = _loc5 ? (this._nY - this.__height) : (this._nY);
        if (_loc6 > _loc2 - this.__width)
        {
            this._x = _loc2 - this.__width;
        }
        else if (_loc6 < 0)
        {
            this._x = 0;
        }
        else
        {
            this._x = _loc6;
        } // end else if
        if (_loc7 > _loc3 - this.__height)
        {
            this._y = _loc3 - this.__height;
        }
        else if (_loc7 < 0)
        {
            this._y = 0;
        }
        else
        {
            this._y = _loc7;
        } // end else if
        this._visible = true;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this.drawRoundRect(this._mcBackground, 0, 0, 1, 1, 0, _loc2.bgcolor);
        this._mcBackground._alpha = _loc2.bgalpha;
        this._tfTextFormat = new TextFormat();
        this._tfTextFormat.font = _loc2.font;
        this._tfTextFormat.size = _loc2.size;
        this._tfTextFormat.color = _loc2.color;
        this._tfTextFormat.bold = _loc2.bold;
        this._tfTextFormat.italic = _loc2.italic;
        this._tfTextFormat.size = _loc2.size;
        this._tfTextFormat.size = _loc2.size;
        this._tfText.embedFonts = _loc2.embedfonts;
        this._tfText.antiAliasType = _loc2.antialiastype;
    };
    _loc1.layoutContent = function ()
    {
        this._tfText.htmlText = this._sText;
        this._tfText.setTextFormat(this._tfTextFormat);
        this.setSize(this._tfText.textWidth + 4, this._tfText.textHeight + 4);
        this._mcBackground._width = this.__width;
        this._mcBackground._height = this.__height;
    };
    _loc1.onKeyDown = function ()
    {
        this.removeMovieClip();
    };
    _loc1.onMouseDown = function ()
    {
        this.removeMovieClip();
    };
    _loc1.addProperty("y", function ()
    {
    }, _loc1.__set__y);
    _loc1.addProperty("params", function ()
    {
    }, _loc1.__set__params);
    _loc1.addProperty("x", function ()
    {
    }, _loc1.__set__x);
    _loc1.addProperty("text", function ()
    {
    }, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ToolTip = function ()
    {
        super();
    }).CLASS_NAME = "ToolTip";
    (_global.ank.gapi.controls.ToolTip = function ()
    {
        super();
    }).MAX_WIDTH = 250;
} // end if
#endinitclip
