// Action script...

// [Initial MovieClip Action of sprite 8]
#initclip 186
class ank.gapi.controls.ToolTip extends ank.gapi.core.UIBasicComponent
{
    var _oParams, __get__params, _sText, __get__initialized, __get__text, _nX, __get__x, _nY, __get__y, _visible, createEmptyMovieClip, createTextField, _tfText, addToQueue, gapi, __width, _x, __height, _y, getStyle, _mcBackground, drawRoundRect, _tfTextFormat, setSize, removeMovieClip, __set__params, __set__text, __set__x, __set__y;
    function ToolTip()
    {
        super();
    } // End of the function
    function set params(oParams)
    {
        _oParams = oParams;
        //return (this.params());
        null;
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        if (this.__get__initialized())
        {
            this.layoutContent();
        } // end if
        //return (this.text());
        null;
    } // End of the function
    function set x(nX)
    {
        _nX = nX;
        if (this.__get__initialized())
        {
            this.placeToolTip();
        } // end if
        //return (this.x());
        null;
    } // End of the function
    function set y(nY)
    {
        _nY = nY;
        if (this.__get__initialized())
        {
            this.placeToolTip();
        } // end if
        //return (this.y());
        null;
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ToolTip.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _visible = false;
        this.createEmptyMovieClip("_mcBackground", 10);
        this.createTextField("_tfText", 20, 0, 0, ank.gapi.controls.ToolTip.MAX_WIDTH, 100);
        _tfText.wordWrap = true;
        _tfText.selectable = false;
        _tfText.autoSize = "left";
        _tfText.multiline = true;
        _tfText.html = true;
        this.addToQueue({object: this, method: layoutContent});
        this.addToQueue({object: this, method: placeToolTip});
        Key.addListener(this);
    } // End of the function
    function placeToolTip()
    {
        var _loc3 = _oParams.bXLimit || _oParams.bXLimit == undefined ? (gapi.screenWidth) : (Number.MAX_VALUE);
        var _loc2 = _oParams.bYLimit || _oParams.bYLimit == undefined ? (gapi.screenHeight) : (Number.MAX_VALUE);
        if (_nX > _loc3 - __width)
        {
            _x = _loc3 - __width;
        }
        else if (_nX < 0)
        {
            _x = 0;
        }
        else
        {
            _x = _nX;
        } // end else if
        if (_nY > _loc2 - __height)
        {
            _y = _loc2 - __height;
        }
        else if (_nY < 0)
        {
            _y = 0;
        }
        else
        {
            _y = _nY;
        } // end else if
        _visible = true;
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        this.drawRoundRect(_mcBackground, 0, 0, 1, 1, 0, _loc2.bgcolor);
        _mcBackground._alpha = _loc2.bgalpha;
        _tfTextFormat = new TextFormat();
        _tfTextFormat.font = _loc2.font;
        _tfTextFormat.size = _loc2.size;
        _tfTextFormat.color = _loc2.color;
        _tfTextFormat.bold = _loc2.bold;
        _tfTextFormat.italic = _loc2.italic;
        _tfTextFormat.size = _loc2.size;
        _tfTextFormat.size = _loc2.size;
        _tfText.embedFonts = _loc2.embedfonts;
    } // End of the function
    function layoutContent()
    {
        _tfText.htmlText = _sText;
        _tfText.setTextFormat(_tfTextFormat);
        this.setSize(_tfText.textWidth + 4, _tfText.textHeight + 4);
        _mcBackground._width = __width;
        _mcBackground._height = __height;
    } // End of the function
    function onKeyDown()
    {
        this.removeMovieClip();
    } // End of the function
    function onMouseDown()
    {
        this.removeMovieClip();
    } // End of the function
    static var CLASS_NAME = "ToolTip";
    static var MAX_WIDTH = 220;
} // End of Class
#endinitclip
