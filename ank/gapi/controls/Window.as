// Action script...

// [Initial MovieClip Action of sprite 20820]
#initclip 85
if (!ank.gapi.controls.Window)
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
    var _loc1 = (_global.ank.gapi.controls.Window = function ()
    {
        super();
    }).prototype;
    _loc1.__set__title = function (sTitle)
    {
        this.addToQueue({object: this, method: function ()
        {
            this._lblTitle.text = sTitle;
        }});
        //return (this.title());
    };
    _loc1.__get__title = function ()
    {
        return (this._lblTitle.text);
    };
    _loc1.__set__contentPath = function (sContentPath)
    {
        this._bContentLoaded = false;
        this._sContentPath = sContentPath;
        if (sContentPath == "none")
        {
            this.addToQueue({object: this, method: function ()
            {
                this._ldrContent.contentPath = "";
            }});
        }
        else
        {
            this.addToQueue({object: this, method: function ()
            {
                this._ldrContent.contentPath = sContentPath;
            }});
        } // end else if
        //return (this.contentPath());
    };
    _loc1.__get__contentPath = function ()
    {
        return (this._ldrContent.contentPath);
    };
    _loc1.__set__contentParams = function (oParams)
    {
        this.addToQueue({object: this, method: function ()
        {
            this._ldrContent.contentParams = oParams;
        }});
        //return (this.contentParams());
    };
    _loc1.__get__contentParams = function ()
    {
        return (this._ldrContent.contentParams);
    };
    _loc1.__get__content = function ()
    {
        return (this._ldrContent.content);
    };
    _loc1.__set__centerScreen = function (bCenterScreen)
    {
        this._bCenterScreen = bCenterScreen;
        //return (this.centerScreen());
    };
    _loc1.__get__centerScreen = function ()
    {
        return (this._bCenterScreen);
    };
    _loc1.__set__interceptMouseEvent = function (bInterceptMouseEvent)
    {
        this._bInterceptMouseEvent = bInterceptMouseEvent;
        this.useHandCursor = false;
        if (bInterceptMouseEvent)
        {
            this.onRelease = function ()
            {
            };
        }
        else
        {
            delete this.onRelease;
        } // end else if
        //return (this.interceptMouseEvent());
    };
    _loc1.__get__interceptMouseEvent = function ()
    {
        return (this._bInterceptMouseEvent);
    };
    _loc1.setPreferedSize = function ()
    {
        this._ldrContent._x = this._ldrContent._y = 0;
        var _loc2 = this._ldrContent.content.getBounds(this);
        var _loc3 = _loc2.xMax - _loc2.xMin;
        var _loc4 = _loc2.yMax - _loc2.yMin;
        var _loc5 = this.getStyle();
        var _loc6 = _loc5.cornerradius;
        var _loc7 = _loc5.borderwidth != undefined ? (_loc5.borderwidth) : (0);
        var _loc8 = _loc5.titleheight;
        this._ldrContent._x = _loc7 - _loc2.xMin;
        this._ldrContent._y = _loc7 + _loc8 - _loc2.yMin;
        this.setSize(2 * _loc7 + _loc3, 2 * _loc7 + _loc8 + _loc4 + (typeof(_loc6) == "object" ? (Math.max(_loc6.bl, _loc6.br)) : (_loc6)));
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Window.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcBorder", 10);
        this.createEmptyMovieClip("_mcBackground", 20);
        this.createEmptyMovieClip("_mcTitle", 30);
        this.attachMovie("Loader", "_ldrContent", 40);
        this._ldrContent.addEventListener("complete", this);
        this.attachMovie("Label", "_lblTitle", 50, {_x: ank.gapi.controls.Window.LBL_TITLE_LEFT_PADDING, _y: ank.gapi.controls.Window.LBL_TITLE_TOP_PADDING});
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._lblTitle.setSize(this.__width - ank.gapi.controls.Window.LBL_TITLE_LEFT_PADDING, ank.gapi.controls.Window.LBL_TITLE_HEIGHT);
        if (this._bInitialized)
        {
            this.draw();
        } // end if
        if (this._bCenterScreen)
        {
            this._x = (this.gapi.screenWidth - this.__width) / 2;
            this._y = (this.gapi.screenHeight - this.__height) / 2;
        } // end if
    };
    _loc1.draw = function ()
    {
        if (this._sContentPath != "none" && !this._bContentLoaded)
        {
            return;
        } // end if
        var _loc2 = this.getStyle();
        this._lblTitle.styleName = _loc2.titlestyle;
        var _loc3 = _loc2.cornerradius;
        var _loc4 = _loc2.bordercolor;
        var _loc5 = _loc2.borderwidth != undefined ? (_loc2.borderwidth) : (0);
        var _loc6 = _loc2.backgroundcolor;
        var _loc7 = _loc2.backgroundalpha != undefined ? (_loc2.backgroundalpha) : (100);
        var _loc8 = _loc2.backgroundrotation != undefined ? (_loc2.backgroundrotation) : (0);
        var _loc9 = _loc2.backgroundradient;
        var _loc10 = _loc2.backgroundratio;
        var _loc11 = _loc2.displaytitle != undefined ? (_loc2.displaytitle) : (true);
        var _loc12 = _loc2.titlecolor;
        var _loc13 = _loc2.titleheight;
        if (typeof(_loc3) == "object")
        {
            var _loc14 = {tl: _loc3.tl - _loc5, tr: _loc3.tr - _loc5, br: _loc3.bl - _loc5, bl: _loc3.bl - _loc5};
        }
        else
        {
            _loc14 = _loc3 - _loc5;
        } // end else if
        if (typeof(_loc3) == "object")
        {
            var _loc15 = {tl: _loc3.tl - _loc5, tr: _loc3.tr - _loc5, br: 0, bl: 0};
        }
        else
        {
            _loc15 = {tl: _loc3 - _loc5, tr: _loc3 - _loc5, bl: 0, br: 0};
        } // end else if
        this._mcBorder.clear();
        this._mcBackground.clear();
        this._mcTitle.clear();
        this.drawRoundRect(this._mcBorder, 0, 0, this.__width, this.__height, _loc3, _loc4);
        this.drawRoundRect(this._mcBackground, _loc5, _loc5, this.__width - 2 * _loc5, this.__height - 2 * _loc5, _loc14, _loc6, _loc7, _loc8, _loc9, _loc10);
        if (_loc11)
        {
            this.drawRoundRect(this._mcTitle, _loc5, _loc5, this.__width - 2 * _loc5, _loc13, _loc15, _loc12);
        } // end if
    };
    _loc1.complete = function ()
    {
        this._bContentLoaded = true;
        this.dispatchEvent({type: "complete"});
        this.setPreferedSize();
    };
    _loc1.addProperty("contentPath", _loc1.__get__contentPath, _loc1.__set__contentPath);
    _loc1.addProperty("interceptMouseEvent", _loc1.__get__interceptMouseEvent, _loc1.__set__interceptMouseEvent);
    _loc1.addProperty("title", _loc1.__get__title, _loc1.__set__title);
    _loc1.addProperty("content", _loc1.__get__content, function ()
    {
    });
    _loc1.addProperty("centerScreen", _loc1.__get__centerScreen, _loc1.__set__centerScreen);
    _loc1.addProperty("contentParams", _loc1.__get__contentParams, _loc1.__set__contentParams);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Window = function ()
    {
        super();
    }).CLASS_NAME = "Window";
    (_global.ank.gapi.controls.Window = function ()
    {
        super();
    }).LBL_TITLE_HEIGHT = 25;
    (_global.ank.gapi.controls.Window = function ()
    {
        super();
    }).LBL_TITLE_TOP_PADDING = 5;
    (_global.ank.gapi.controls.Window = function ()
    {
        super();
    }).LBL_TITLE_LEFT_PADDING = 5;
    _loc1._bDrag = false;
    _loc1._bCenterScreen = true;
    _loc1._sContentPath = "none";
    _loc1._bContentLoaded = false;
    _loc1._bInterceptMouseEvent = false;
} // end if
#endinitclip
