// Action script...

// [Initial MovieClip Action of sprite 135]
#initclip 20
class ank.gapi.controls.Window extends ank.gapi.core.UIBasicComponent
{
    var _lblTitle, addToQueue, __get__title, _ldrContent, __get__contentPath, __get__contentParams, __get__centerScreen, useHandCursor, __get__interceptMouseEvent, getStyle, setSize, createEmptyMovieClip, attachMovie, __width, _bInitialized, gapi, _x, __height, _y, _mcBorder, _mcBackground, _mcTitle, drawRoundRect, dispatchEvent, __set__centerScreen, __get__content, __set__contentParams, __set__contentPath, __set__interceptMouseEvent, __set__title;
    function Window()
    {
        super();
    } // End of the function
    function set title(sTitle)
    {
        this.addToQueue({object: this, method: function ()
        {
            _lblTitle.text = sTitle;
        }});
        //return (this.title());
        null;
    } // End of the function
    function get title()
    {
        //return (_lblTitle.text());
    } // End of the function
    function set contentPath(sContentPath)
    {
        _bContentLoaded = false;
        _sContentPath = sContentPath;
        if (sContentPath == "none")
        {
            this.addToQueue({object: this, method: function ()
            {
                _ldrContent.contentPath = "";
            }});
        }
        else
        {
            this.addToQueue({object: this, method: function ()
            {
                _ldrContent.contentPath = sContentPath;
            }});
        } // end else if
        //return (this.contentPath());
        null;
    } // End of the function
    function get contentPath()
    {
        //return (_ldrContent.contentPath());
    } // End of the function
    function set contentParams(oParams)
    {
        this.addToQueue({object: this, method: function ()
        {
            _ldrContent.contentParams = oParams;
        }});
        //return (this.contentParams());
        null;
    } // End of the function
    function get contentParams()
    {
        //return (_ldrContent.contentParams());
    } // End of the function
    function get content()
    {
        //return (_ldrContent.content());
    } // End of the function
    function set centerScreen(bCenterScreen)
    {
        _bCenterScreen = bCenterScreen;
        //return (this.centerScreen());
        null;
    } // End of the function
    function get centerScreen()
    {
        return (_bCenterScreen);
    } // End of the function
    function set interceptMouseEvent(bInterceptMouseEvent)
    {
        _bInterceptMouseEvent = bInterceptMouseEvent;
        useHandCursor = false;
        if (bInterceptMouseEvent)
        {
            function onRelease()
            {
            } // End of the function
        }
        else
        {
            delete this.onRelease;
        } // end else if
        //return (this.interceptMouseEvent());
        null;
    } // End of the function
    function get interceptMouseEvent()
    {
        return (_bInterceptMouseEvent);
    } // End of the function
    function setPreferedSize()
    {
        _ldrContent._x = _ldrContent._y = 0;
        var _loc2 = _ldrContent.content.getBounds(this);
        var _loc8 = _loc2.xMax - _loc2.xMin;
        var _loc7 = _loc2.yMax - _loc2.yMin;
        var _loc3 = this.getStyle();
        var _loc4 = _loc3.cornerradius;
        var _loc5 = _loc3.borderwidth != undefined ? (_loc3.borderwidth) : (0);
        var _loc6 = _loc3.titleheight;
        _ldrContent._x = _loc5 - _loc2.xMin;
        _ldrContent._y = _loc5 + _loc6 - _loc2.yMin;
        this.setSize(2 * _loc5 + _loc8, 2 * _loc5 + _loc6 + _loc7 + (typeof(_loc4) == "object" ? (Math.max(_loc4.bl, _loc4.br)) : (_loc4)));
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Window.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcBorder", 10);
        this.createEmptyMovieClip("_mcBackground", 20);
        this.createEmptyMovieClip("_mcTitle", 30);
        this.attachMovie("Loader", "_ldrContent", 40);
        _ldrContent.addEventListener("complete", this);
        this.attachMovie("Label", "_lblTitle", 50, {_x: ank.gapi.controls.Window.LBL_TITLE_LEFT_PADDING, _y: ank.gapi.controls.Window.LBL_TITLE_TOP_PADDING});
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _lblTitle.setSize(__width - ank.gapi.controls.Window.LBL_TITLE_LEFT_PADDING, ank.gapi.controls.Window.LBL_TITLE_HEIGHT);
        if (_bInitialized)
        {
            this.draw();
        } // end if
        if (_bCenterScreen)
        {
            _x = (gapi.screenWidth - __width) / 2;
            _y = (gapi.screenHeight - __height) / 2;
        } // end if
    } // End of the function
    function draw()
    {
        if (_sContentPath != "none" && !_bContentLoaded)
        {
            return;
        } // end if
        var _loc4 = this.getStyle();
        _lblTitle.__set__styleName(_loc4.titlestyle);
        var _loc3 = _loc4.cornerradius;
        var _loc7 = _loc4.bordercolor;
        var _loc2 = _loc4.borderwidth != undefined ? (_loc4.borderwidth) : (0);
        var _loc10 = _loc4.backgroundcolor;
        var _loc9 = _loc4.titlecolor;
        var _loc8 = _loc4.titleheight;
        var _loc6;
        if (typeof(_loc3) == "object")
        {
            _loc6 = {tl: _loc3.tl - _loc2, tr: _loc3.tr - _loc2, br: _loc3.bl - _loc2, bl: _loc3.bl - _loc2};
        }
        else
        {
            _loc6 = _loc3 - _loc2;
        } // end else if
        var _loc5;
        if (typeof(_loc3) == "object")
        {
            _loc5 = {tl: _loc3.tl - _loc2, tr: _loc3.tr - _loc2, br: 0, bl: 0};
        }
        else
        {
            _loc5 = {tl: _loc3 - _loc2, tr: _loc3 - _loc2, bl: 0, br: 0};
        } // end else if
        _mcBorder.clear();
        _mcBackground.clear();
        _mcTitle.clear();
        this.drawRoundRect(_mcBorder, 0, 0, __width, __height, _loc3, _loc7);
        this.drawRoundRect(_mcBackground, _loc2, _loc2, __width - 2 * _loc2, __height - 2 * _loc2, _loc6, _loc10);
        this.drawRoundRect(_mcTitle, _loc2, _loc2, __width - 2 * _loc2, _loc8, _loc5, _loc9);
    } // End of the function
    function complete()
    {
        _bContentLoaded = true;
        this.dispatchEvent({type: "complete"});
        this.setPreferedSize();
    } // End of the function
    static var CLASS_NAME = "Window";
    static var LBL_TITLE_HEIGHT = 25;
    static var LBL_TITLE_TOP_PADDING = 5;
    static var LBL_TITLE_LEFT_PADDING = 5;
    var _bDrag = false;
    var _bCenterScreen = true;
    var _sContentPath = "none";
    var _bContentLoaded = false;
    var _bInterceptMouseEvent = false;
} // End of Class
#endinitclip
