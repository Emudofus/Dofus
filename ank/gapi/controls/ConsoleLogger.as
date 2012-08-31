// Action script...

// [Initial MovieClip Action of sprite 38]
#initclip 57
class ank.gapi.controls.ConsoleLogger extends ank.gapi.core.UIBasicComponent
{
    var _aLogs, __height, __width, createTextField, _tText, getStyle;
    function ConsoleLogger()
    {
        super();
    } // End of the function
    function log(sText, sHColor, sLColor)
    {
        var _loc2 = new Object();
        _loc2.text = sText;
        _loc2.hColor = sHColor == undefined ? ("#FFFFFF") : (sHColor);
        _loc2.lColor = sLColor == undefined ? ("#999999") : (sLColor);
        _aLogs.push(_loc2);
        this.refreshLogs();
    } // End of the function
    function clear()
    {
        _aLogs = new Array();
        this.refreshLogs();
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ConsoleLogger.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createTextField("_tText", 10, 0, 0, __width, __height);
        _tText.html = true;
        _tText.text = "";
        _tText.selectable = false;
        _tText.multiline = true;
        _aLogs = new Array();
    } // End of the function
    function size()
    {
        super.size();
        _tText._width = __width;
        _tText._height = __height;
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _tText.embedFonts = this.getStyle().embedfonts;
    } // End of the function
    function refreshLogs()
    {
        var _loc5 = "";
        var _loc6 = _aLogs.length - 1;
        var _loc3;
        var _loc4 = this.getStyle();
        for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
        {
            _loc3 = _aLogs[_loc2];
            _loc5 = _loc5 + ("<p><font size=\'" + _loc4.size + "\' face=\'" + _loc4.font + "\' color=\'" + _loc3.lColor + "\'>" + _loc3.text + "</font></p>");
        } // end of for
        _loc3 = _aLogs[_loc6];
        if (_loc3 != undefined)
        {
            _loc5 = _loc5 + ("<p><font size=\'" + _loc4.size + "\' face=\'" + _loc4.font + "\' color=\'" + _loc3.hColor + "\'>" + _loc3.text + "</font></p>");
        } // end if
        _tText.htmlText = _loc5;
        _tText.scroll = _tText.maxscroll;
    } // End of the function
    static var CLASS_NAME = "ConsoleLogger";
} // End of Class
#endinitclip
