// Action script...

// [Initial MovieClip Action of sprite 33]
#initclip 187
class ank.gapi.controls.PopupMenu extends ank.gapi.core.UIBasicComponent
{
    var _aItems, createEmptyMovieClip, _bInitialized, __width, __height, _mcItems, _mcBorder, _mcBackground, _mcForeground, getStyle, drawRoundRect, _parent, _nLastTimer, setSize, gapi, _x, _y, removeMovieClip;
    function PopupMenu()
    {
        super();
    } // End of the function
    function addStaticItem(text)
    {
        var _loc2 = new Object();
        _loc2.text = text;
        _loc2.bStatic = true;
        _loc2.bEnabled = false;
        _aItems.push(_loc2);
    } // End of the function
    function addItem(text, obj, fn, args, bEnabled)
    {
        if (bEnabled == undefined)
        {
            bEnabled = true;
        } // end if
        var _loc2 = new Object();
        _loc2.text = text;
        _loc2.bStatic = false;
        _loc2.bEnabled = bEnabled;
        _loc2.obj = obj;
        _loc2.fn = fn;
        _loc2.args = args;
        _aItems.push(_loc2);
    } // End of the function
    function show(nX, nY, bMaximize)
    {
        this.layoutContent(nX, nY, bMaximize);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.PopupMenu.CLASS_NAME);
        _aItems = new Array();
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcBorder", 10);
        this.createEmptyMovieClip("_mcBackground", 20);
        this.createEmptyMovieClip("_mcForeground", 30);
        this.createEmptyMovieClip("_mcItems", 40);
        Mouse.addListener(this);
    } // End of the function
    function size()
    {
        this.arrange();
    } // End of the function
    function arrange()
    {
        if (_bInitialized && __width != undefined && __height != undefined)
        {
            _mcItems._x = _mcItems._y = 2;
            _mcBorder._width = __width;
            _mcBorder._height = __height;
            _mcBackground._x = _mcBackground._y = 1;
            _mcBackground._width = __width - 2;
            _mcBackground._height = __height - 2;
            _mcForeground._x = _mcForeground._y = 2;
            _mcForeground._width = __width - 4;
            _mcForeground._height = __height - 4;
            var _loc2 = _aItems.length;
            while (_loc2-- > 0)
            {
                this.arrangeItem(_loc2, __width - 4);
            } // end while
        } // end if
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _mcBorder.clear();
        _mcBackground.clear();
        _mcForeground.clear();
        this.drawRoundRect(_mcBorder, 0, 0, 1, 1, 0, _loc2.bordercolor);
        this.drawRoundRect(_mcBackground, 0, 0, 1, 1, 0, _loc2.backgroundcolor);
        this.drawRoundRect(_mcForeground, 0, 0, 1, 1, 0, _loc2.foregroundcolor);
    } // End of the function
    function drawItem(i, index)
    {
        var _loc2 = _mcItems.createEmptyMovieClip("item" + index, index);
        var _loc3 = (ank.gapi.controls.Label)(_loc2.attachMovie("Label", "_lbl", 20, {styleName: this.getStyle().labelenabledstyle, text: i.text}));
        _loc3.setSize(ank.gapi.controls.PopupMenu.MAX_ITEM_WIDTH, ank.gapi.controls.PopupMenu.ITEM_HEIGHT);
        if (i.bStatic)
        {
            _loc3.__set__styleName(this.getStyle().labelstaticstyle);
        }
        else if (!i.bEnabled)
        {
            _loc3.__set__styleName(this.getStyle().labeldisabledstyle);
        } // end else if
        _loc2.createEmptyMovieClip("bg", 10);
        this.drawRoundRect(_loc2.bg, 0, 0, 1, ank.gapi.controls.PopupMenu.ITEM_HEIGHT, 0, this.getStyle().itembgcolor);
        _loc2._y = index * ank.gapi.controls.PopupMenu.ITEM_HEIGHT;
        if (i.bEnabled)
        {
            _loc2.bg.onPress = function ()
            {
                i.fn.apply(i.obj, i.args);
            };
            _loc2.bg.onRollOver = function ()
            {
                var _loc2 = new Color(this);
                _loc2.setRGB(_parent._parent._parent.getStyle().itemovercolor);
            };
            _loc2.bg.onRollOut = _loc2.bg.onReleaseOutside = function ()
            {
                var _loc2 = new Color(this);
                _loc2.setRGB(_parent._parent._parent.getStyle().itembgcolor);
            };
        }
        else
        {
            _loc2.bg.onPress = function ()
            {
            };
            _loc2.bg.useHandCursor = false;
            var _loc4 = new Color(_loc2.bg);
            if (i.bStatic)
            {
                _loc4.setRGB(this.getStyle().itemstaticbgcolor);
            }
            else
            {
                _loc4.setRGB(this.getStyle().itembgcolor);
            } // end else if
        } // end else if
        //return (_loc3.textWidth());
    } // End of the function
    function arrangeItem(nIndex, nWidth)
    {
        var _loc2 = _mcItems["item" + nIndex];
        _loc2._lbl.setSize(nWidth, ank.gapi.controls.PopupMenu.ITEM_HEIGHT);
        _loc2.bg._width = nWidth;
    } // End of the function
    function layoutContent(x, y, bMaximize)
    {
        _nLastTimer = getTimer();
        var _loc5 = _aItems.length;
        var _loc4 = 0;
        var _loc3 = _loc5;
        while (_loc3-- > 0)
        {
            var _loc2 = this.drawItem(_aItems[_loc3], _loc3);
            if (_loc2 > _loc4)
            {
                _loc4 = _loc2;
            } // end if
        } // end while
        this.setSize(_loc4 + 16, ank.gapi.controls.PopupMenu.ITEM_HEIGHT * _loc5 + 4);
        var _loc6 = bMaximize ? (Stage.width) : (gapi.screenWidth);
        var _loc7 = bMaximize ? (Stage.height) : (gapi.screenHeight);
        if (x > _loc6 - __width)
        {
            _x = _loc6 - __width;
        }
        else if (x < 0)
        {
            _x = 0;
        }
        else
        {
            _x = x;
        } // end else if
        if (y > _loc7 - __height)
        {
            _y = _loc7 - __height;
        }
        else if (y < 0)
        {
            _y = 0;
        }
        else
        {
            _y = y;
        } // end else if
    } // End of the function
    function remove()
    {
        Mouse.removeListener(this);
        this.removeMovieClip();
    } // End of the function
    function onMouseUp()
    {
        if (getTimer() - _nLastTimer > 400)
        {
            this.remove();
        } // end if
    } // End of the function
    static var CLASS_NAME = "PopupMenu";
    static var MAX_ITEM_WIDTH = 180;
    static var ITEM_HEIGHT = 18;
} // End of Class
#endinitclip
