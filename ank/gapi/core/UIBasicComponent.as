// Action script...

// [Initial MovieClip Action of sprite 20482]
#initclip 3
if (!ank.gapi.core.UIBasicComponent)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.core)
    {
        _global.ank.gapi.core = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.core.UIBasicComponent = function ()
    {
        super();
        this.init();
        this.createChildren();
        this.draw();
        this.arrange();
        this.size();
        this._bInitialized = true;
    }).prototype;
    _loc1.__set__gapi = function (mcGAPI)
    {
        this._mcGAPI = mcGAPI;
        //return (this.gapi());
    };
    _loc1.__get__gapi = function ()
    {
        if (this._mcGAPI == undefined)
        {
            return (this._parent.gapi);
        }
        else
        {
            return (this._mcGAPI);
        } // end else if
    };
    _loc1.__get__className = function ()
    {
        return (this._sClassName);
    };
    _loc1.__set__enabled = function (bEnabled)
    {
        this._bEnabled = bEnabled;
        this.addToQueue({object: this, method: this.setEnabled});
        //return (this.enabled());
    };
    _loc1.__get__enabled = function ()
    {
        return (this._bEnabled);
    };
    _loc1.__set__styleName = function (sStyleName)
    {
        this._sStyleName = sStyleName;
        if (this._bInitialized && (sStyleName != "none" && sStyleName != undefined))
        {
            this.draw();
        } // end if
        //return (this.styleName());
    };
    _loc1.__get__styleName = function ()
    {
        var _loc2 = this._sStyleName;
        if (_loc2.length == 0 || (_loc2 == undefined || _loc2 == "default"))
        {
            for (var _loc3 = this._parent; !(_loc3 instanceof ank.gapi.core.UIBasicComponent) && _loc3 != undefined; _loc3 = _loc3._parent)
            {
            } // end of for
            _loc2 = _loc3.styleName;
        } // end if
        if (_loc2 == undefined)
        {
            _loc2 = this._sClassName;
        } // end if
        return (_loc2);
    };
    _loc1.__set__width = function (nWidth)
    {
        this.setSize(nWidth, null);
        //return (this.width());
    };
    _loc1.__get__width = function ()
    {
        return (this.__width);
    };
    _loc1.__set__height = function (nHeight)
    {
        this.setSize(null, nHeight);
        //return (this.height());
    };
    _loc1.__get__height = function ()
    {
        return (this.__height);
    };
    _loc1.__set__params = function (oParams)
    {
        this._oParams = oParams;
        //return (this.params());
    };
    _loc1.__get__params = function ()
    {
        return (this._oParams);
    };
    _loc1.__get__initialized = function ()
    {
        return (this._bInitialized);
    };
    _loc1.setSize = function (w, h)
    {
        if (Math.abs(this._rotation) == 90)
        {
            var _loc4 = w;
            w = h;
            h = _loc4;
        } // end if
        if (w != undefined && w != null)
        {
            this.__width = w;
        } // end if
        if (h != undefined && h != null)
        {
            this.__height = h;
        } // end if
        this.size();
    };
    _loc1.move = function (x, y)
    {
        if (x != undefined)
        {
            this._x = x;
        } // end if
        if (x != undefined)
        {
            this._y = y;
        } // end if
    };
    _loc1.init = function (bDontHideBoundingBox, sClassName)
    {
        this._sClassName = sClassName;
        if (Math.ceil(this._rotation % 180) > 45)
        {
            this.__width = this._height;
            this.__height = this._width;
        }
        else
        {
            this.__width = this._width;
            this.__height = this._height;
        } // end else if
        if (!bDontHideBoundingBox)
        {
            this.boundingBox_mc._visible = false;
            this.boundingBox_mc._width = this.boundingBox_mc._height = 0;
        } // end if
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.getStyle = function ()
    {
        return (ank.gapi.styles.StylesManager.getStyle(this.styleName));
    };
    _loc1.size = function ()
    {
        this.initScale();
    };
    _loc1.initScale = function ()
    {
        this._xscale = this._yscale = 100;
    };
    _loc1.drawBorder = function ()
    {
        if (this.border_mc == undefined)
        {
            this.createEmptyMovieClip("border_mc", 0);
        } // end if
        this.border_mc.clear();
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 7305079, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(this.__width, 0);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 9542041, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(this.__width, this.__height);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 14015965, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(0, this.__height);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 9542041, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(0, 0);
        this.border_mc.moveTo(1, 1);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 13290700, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(this.__width - 1, 1);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 14015965, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(this.__width - 1, this.__height - 1);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 15658734, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(1, this.__height - 1);
        this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 14015965, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        this.border_mc.lineTo(1, 1);
    };
    _loc1.drawRoundRect = function (mc, x, y, w, h, r, c, alpha, rot, gradient, ratios)
    {
        if (typeof(r) == "object")
        {
            var _loc13 = r.br;
            var _loc14 = r.bl;
            var _loc15 = r.tl;
            var _loc16 = r.tr;
        }
        else
        {
            _loc16 = r;
            _loc15 = r;
            _loc14 = r;
            _loc13 = r;
        } // end else if
        if (alpha == undefined)
        {
            alpha = 100;
        } // end if
        if (typeof(c) == "object")
        {
            if (typeof(alpha) != "object")
            {
                var _loc17 = [alpha, alpha];
            }
            else
            {
                _loc17 = alpha;
            } // end else if
            if (ratios == undefined)
            {
                ratios = [0, 255];
            } // end if
            var _loc18 = h * 7.000000E-001;
            if (typeof(rot) != "object")
            {
                var _loc19 = {matrixType: "box", x: -_loc18, y: _loc18, w: w * 2, h: h * 4, r: rot * 1.745329E-002};
            }
            else
            {
                _loc19 = rot;
                if (_loc19.w == undefined)
                {
                    _loc19.w = w;
                } // end if
                if (_loc19.h == undefined)
                {
                    _loc19.h = h;
                } // end if
            } // end else if
            if (gradient == "radial")
            {
                mc.beginGradientFill("radial", c, _loc17, ratios, _loc19);
            }
            else
            {
                mc.beginGradientFill("linear", c, _loc17, ratios, _loc19);
            } // end else if
        }
        else if (c != undefined)
        {
            mc.beginFill(c, alpha);
        } // end else if
        r = _loc13;
        if (r != 0)
        {
            var _loc20 = r - r * 7.071068E-001;
            var _loc21 = r - r * 4.142136E-001;
            mc.moveTo(x + w, y + h - r);
            mc.lineTo(x + w, y + h - r);
            mc.curveTo(x + w, y + h - _loc21, x + w - _loc20, y + h - _loc20);
            mc.curveTo(x + w - _loc21, y + h, x + w - r, y + h);
        }
        else
        {
            mc.moveTo(x + w, y + h);
        } // end else if
        r = _loc14;
        if (r != 0)
        {
            var _loc22 = r - r * 7.071068E-001;
            var _loc23 = r - r * 4.142136E-001;
            mc.lineTo(x + r, y + h);
            mc.curveTo(x + _loc23, y + h, x + _loc22, y + h - _loc22);
            mc.curveTo(x, y + h - _loc23, x, y + h - r);
        }
        else
        {
            mc.lineTo(x, y + h);
        } // end else if
        r = _loc15;
        if (r != 0)
        {
            var _loc24 = r - r * 7.071068E-001;
            var _loc25 = r - r * 4.142136E-001;
            mc.lineTo(x, y + r);
            mc.curveTo(x, y + _loc25, x + _loc24, y + _loc24);
            mc.curveTo(x + _loc25, y, x + r, y);
        }
        else
        {
            mc.lineTo(x, y);
        } // end else if
        r = _loc16;
        if (r != 0)
        {
            var _loc26 = r - r * 7.071068E-001;
            var _loc27 = r - r * 4.142136E-001;
            mc.lineTo(x + w - r, y);
            mc.curveTo(x + w - _loc27, y, x + w - _loc26, y + _loc26);
            mc.curveTo(x + w, y + _loc27, x + w, y + r);
            mc.lineTo(x + w, y + h - r);
        }
        else
        {
            mc.lineTo(x + w, y);
            mc.lineTo(x + w, y + h);
        } // end else if
        if (c != undefined)
        {
            mc.endFill();
        } // end if
    };
    _loc1.setMovieClipColor = function (mc, nColor)
    {
        var _loc4 = new Color(mc);
        _loc4.setRGB(nColor);
        if (nColor == -1)
        {
            mc._alpha = 0;
        } // end if
    };
    _loc1.setMovieClipTransform = function (mc, oTransformation)
    {
        var _loc4 = new Color(mc);
        _loc4.setTransform(oTransformation);
    };
    _loc1.addProperty("styleName", _loc1.__get__styleName, _loc1.__set__styleName);
    _loc1.addProperty("gapi", _loc1.__get__gapi, _loc1.__set__gapi);
    _loc1.addProperty("enabled", _loc1.__get__enabled, _loc1.__set__enabled);
    _loc1.addProperty("className", _loc1.__get__className, function ()
    {
    });
    _loc1.addProperty("initialized", _loc1.__get__initialized, function ()
    {
    });
    _loc1.addProperty("params", _loc1.__get__params, _loc1.__set__params);
    _loc1.addProperty("height", _loc1.__get__height, _loc1.__set__height);
    _loc1.addProperty("width", _loc1.__get__width, _loc1.__set__width);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.core.UIBasicComponent = function ()
    {
        super();
        this.init();
        this.createChildren();
        this.draw();
        this.arrange();
        this.size();
        this._bInitialized = true;
    }).BORDER_TICKNESS = 1;
    (_global.ank.gapi.core.UIBasicComponent = function ()
    {
        super();
        this.init();
        this.createChildren();
        this.draw();
        this.arrange();
        this.size();
        this._bInitialized = true;
    }).BORDER_ALPHA = 50;
    _loc1._bInitialized = false;
    _loc1._sStyleName = "default";
    _loc1._bEnabled = true;
} // end if
#endinitclip
