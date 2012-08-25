// Action script...

// [Initial MovieClip Action of sprite 20812]
#initclip 77
if (!ank.gapi.controls.ConsoleLogger)
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
    var _loc1 = (_global.ank.gapi.controls.ConsoleLogger = function ()
    {
        super();
    }).prototype;
    _loc1.__get__shadowy = function ()
    {
        return (this._bShadowy);
    };
    _loc1.__set__shadowy = function (b)
    {
        this._bShadowy = b;
        //return (this.shadowy());
    };
    _loc1.log = function (sText, sHColor, sLColor)
    {
        var _loc5 = new Object();
        _loc5.text = sText;
        _loc5.hColor = sHColor == undefined ? ("#FFFFFF") : (sHColor);
        _loc5.lColor = sLColor == undefined ? ("#999999") : (sLColor);
        this._aLogs.push(_loc5);
        this.refreshLogs();
    };
    _loc1.clear = function ()
    {
        this._aLogs = new Array();
        this.refreshLogs();
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ConsoleLogger.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createTextField("_tText", 10, 0, 0, this.__width, this.__height);
        this._tText.html = true;
        this._tText.text = "";
        this._tText.selectable = false;
        this._tText.multiline = true;
        this._tText.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this._tText.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
        if (this._bShadowy)
        {
            var _loc2 = new Array();
            _loc2.push(new flash.filters.DropShadowFilter(1, 60, 0, 1, 3, 3, 4, 3, false, false, false));
            this._tText.filters = _loc2;
            this._tText.antiAliasType = "advanced";
        } // end if
        this._aLogs = new Array();
    };
    _loc1.size = function ()
    {
        super.size();
        this._tText._width = this.__width;
        this._tText._height = this.__height;
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._tText.embedFonts = this.getStyle().embedfonts;
    };
    _loc1.refreshLogs = function ()
    {
        var _loc2 = "";
        var _loc3 = this._aLogs.length - 1;
        var _loc5 = this.getStyle();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc3)
        {
            var _loc4 = this._aLogs[_loc6];
            _loc2 = _loc2 + ("<p><font size=\'" + _loc5.size + "\' face=\'" + _loc5.font + "\' color=\'" + _loc4.lColor + "\'>" + _loc4.text + "</font></p>");
        } // end while
        _loc4 = this._aLogs[_loc3];
        if (_loc4 != undefined)
        {
            _loc2 = _loc2 + ("<p><font size=\'" + _loc5.size + "\' face=\'" + _loc5.font + "\' color=\'" + _loc4.hColor + "\'>" + _loc4.text + "</font></p>");
        } // end if
        this._tText.htmlText = _loc2;
        this._tText.scroll = this._tText.maxscroll;
    };
    _loc1.onHref = function (sParams)
    {
        this.dispatchEvent({type: "href", params: sParams});
    };
    _loc1.onSetFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "false");
    };
    _loc1.onKillFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "true");
    };
    _loc1.addProperty("shadowy", _loc1.__get__shadowy, _loc1.__set__shadowy);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ConsoleLogger = function ()
    {
        super();
    }).CLASS_NAME = "ConsoleLogger";
} // end if
#endinitclip
