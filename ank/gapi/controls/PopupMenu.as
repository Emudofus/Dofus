// Action script...

// [Initial MovieClip Action of sprite 20668]
#initclip 189
if (!ank.gapi.controls.PopupMenu)
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
    var _loc1 = (_global.ank.gapi.controls.PopupMenu = function ()
    {
        super();
    }).prototype;
    _loc1.addStaticItem = function (text)
    {
        var _loc3 = new Object();
        _loc3.text = text;
        _loc3.bStatic = true;
        _loc3.bEnabled = false;
        this._aItems.push(_loc3);
    };
    _loc1.addItem = function (text, obj, fn, args, bEnabled)
    {
        if (bEnabled == undefined)
        {
            bEnabled = true;
        } // end if
        var _loc7 = new Object();
        _loc7.text = text;
        _loc7.bStatic = false;
        _loc7.bEnabled = bEnabled;
        _loc7.obj = obj;
        _loc7.fn = fn;
        _loc7.args = args;
        this._aItems.push(_loc7);
    };
    _loc1.__get__items = function ()
    {
        return (this._aItems);
    };
    _loc1.show = function (nX, nY, bMaximize, bUseRightCorner, nTimer)
    {
        ank.utils.Timer.removeTimer(this._name);
        if (nX == undefined)
        {
            nX = _root._xmouse;
        } // end if
        if (nY == undefined)
        {
            nY = _root._ymouse;
        } // end if
        this.layoutContent(nX, nY, bMaximize, bUseRightCorner);
        if (!_global.isNaN(Number(nTimer)))
        {
            ank.utils.Timer.setTimer(this, this._name, this, this.remove, nTimer);
            this._bCloseOnMouseUp = false;
        } // end if
        this.addToQueue({object: Mouse, method: Mouse.addListener, params: [this]});
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.PopupMenu.CLASS_NAME);
        this._aItems = new Array();
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcBorder", 10);
        this.createEmptyMovieClip("_mcBackground", 20);
        this.createEmptyMovieClip("_mcForeground", 30);
        this.createEmptyMovieClip("_mcItems", 40);
    };
    _loc1.size = function ()
    {
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        if (this._bInitialized && (this.__width != undefined && this.__height != undefined))
        {
            this._mcItems._x = this._mcItems._y = 2;
            this._mcBorder._width = this.__width;
            this._mcBorder._height = this.__height;
            this._mcBackground._x = this._mcBackground._y = 1;
            this._mcBackground._width = this.__width - 2;
            this._mcBackground._height = this.__height - 2;
            this._mcForeground._x = this._mcForeground._y = 2;
            this._mcForeground._width = this.__width - 4;
            this._mcForeground._height = this.__height - 4;
            var _loc2 = this._aItems.length;
            while (_loc2-- > 0)
            {
                this.arrangeItem(_loc2, this.__width - 4);
            } // end while
        } // end if
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._mcBorder.clear();
        this._mcBackground.clear();
        this._mcForeground.clear();
        this.drawRoundRect(this._mcBorder, 0, 0, 1, 1, 0, _loc2.bordercolor);
        this.drawRoundRect(this._mcBackground, 0, 0, 1, 1, 0, _loc2.backgroundcolor);
        this.drawRoundRect(this._mcForeground, 0, 0, 1, 1, 0, _loc2.foregroundcolor);
    };
    _loc1.drawItem = function (i, index, nY)
    {
        var _loc4 = this._mcItems.createEmptyMovieClip("item" + index, index);
        var _loc5 = (ank.gapi.controls.Label)(_loc4.attachMovie("Label", "_lbl", 20, {_width: ank.gapi.controls.PopupMenu.MAX_ITEM_WIDTH, styleName: this.getStyle().labelenabledstyle, wordWrap: true, text: i.text}));
        _loc5.setPreferedSize("left");
        var _loc6 = Math.max(ank.gapi.controls.PopupMenu.ITEM_HEIGHT, _loc5.textHeight + 6);
        if (i.bStatic)
        {
            _loc5.styleName = this.getStyle().labelstaticstyle;
        }
        else if (!i.bEnabled)
        {
            _loc5.styleName = this.getStyle().labeldisabledstyle;
        } // end else if
        _loc4.createEmptyMovieClip("bg", 10);
        this.drawRoundRect(_loc4.bg, 0, 0, 1, _loc6, 0, this.getStyle().itembgcolor);
        _loc4._y = nY;
        if (i.bEnabled)
        {
            _loc4.bg.onRelease = function ()
            {
                i.fn.apply(i.obj, i.args);
                this._parent._parent._parent.remove(true);
            };
            _loc4.bg.onRollOver = function ()
            {
                var _loc2 = new Color(this);
                _loc2.setRGB(this._parent._parent._parent.getStyle().itemovercolor);
                this._parent._parent._parent.onItemOver();
            };
            _loc4.bg.onRollOut = _loc4.bg.onReleaseOutside = function ()
            {
                var _loc2 = new Color(this);
                _loc2.setRGB(this._parent._parent._parent.getStyle().itembgcolor);
                this._parent._parent._parent.onItemOut();
            };
        }
        else
        {
            _loc4.bg.onPress = function ()
            {
            };
            _loc4.bg.useHandCursor = false;
            var _loc7 = new Color(_loc4.bg);
            if (i.bStatic)
            {
                _loc7.setRGB(this.getStyle().itemstaticbgcolor);
            }
            else
            {
                _loc7.setRGB(this.getStyle().itembgcolor);
            } // end else if
        } // end else if
        return ({w: _loc5.textWidth, h: _loc6});
    };
    _loc1.arrangeItem = function (nIndex, nWidth)
    {
        var _loc4 = this._mcItems["item" + nIndex];
        _loc4._lbl.setSize(nWidth, ank.gapi.controls.PopupMenu.ITEM_HEIGHT);
        _loc4.bg._width = nWidth;
    };
    _loc1.layoutContent = function (x, y, bMaximize, bUseRightCorner)
    {
        var _loc6 = this._aItems.length;
        var _loc7 = 0;
        var _loc8 = 0;
        var _loc9 = 0;
        
        while (++_loc9, _loc9 < this._aItems.length)
        {
            var _loc10 = this.drawItem(this._aItems[_loc9], _loc9, _loc8);
            _loc8 = _loc8 + _loc10.h;
            _loc7 = Math.max(_loc7, _loc10.w);
        } // end while
        this.setSize(_loc7 + 16, _loc8 + 4);
        var _loc11 = bMaximize ? (Stage.width) : (this.gapi.screenWidth);
        var _loc12 = bMaximize ? (Stage.height) : (this.gapi.screenHeight);
        if (bUseRightCorner == true)
        {
            x = x - this.__width;
        } // end if
        if (x > _loc11 - this.__width)
        {
            this._x = _loc11 - this.__width;
        }
        else if (x < 0)
        {
            this._x = 0;
        }
        else
        {
            this._x = x;
        } // end else if
        if (y > _loc12 - this.__height)
        {
            this._y = _loc12 - this.__height;
        }
        else if (y < 0)
        {
            this._y = 0;
        }
        else
        {
            this._y = y;
        } // end else if
    };
    _loc1.remove = function ()
    {
        Mouse.removeListener(this);
        this.removeMovieClip();
    };
    _loc1.onItemOver = function ()
    {
        this._bOver = true;
    };
    _loc1.onItemOut = function ()
    {
        this._bOver = false;
    };
    _loc1.onMouseUp = function ()
    {
        if (!this._bOver && this._bCloseOnMouseUp)
        {
            this.remove();
        } // end if
    };
    _loc1.addProperty("items", _loc1.__get__items, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.PopupMenu = function ()
    {
        super();
    }).CLASS_NAME = "PopupMenu";
    (_global.ank.gapi.controls.PopupMenu = function ()
    {
        super();
    }).MAX_ITEM_WIDTH = 150;
    (_global.ank.gapi.controls.PopupMenu = function ()
    {
        super();
    }).ITEM_HEIGHT = 18;
    _loc1._bOver = false;
    _loc1._bCloseOnMouseUp = true;
} // end if
#endinitclip
