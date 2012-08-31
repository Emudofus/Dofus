// Action script...

// [Initial MovieClip Action of sprite 7]
#initclip 2
class ank.gapi.core.UIBasicComponent extends ank.utils.QueueEmbedMovieClip
{
    var createChildren, draw, arrange, _mcGAPI, __get__gapi, _parent, _sClassName, setEnabled, __get__enabled, __get__styleName, __get__width, __width, __get__height, __height, _oParams, __get__params, _rotation, _x, _y, _height, _width, boundingBox_mc, _yscale, _xscale, onEnterFrame, border_mc, createEmptyMovieClip, __get__className, __set__enabled, __set__gapi, __set__height, __get__initialized, __set__params, __set__styleName, __set__width;
    function UIBasicComponent()
    {
        super();
        this.init();
        this.createChildren();
        this.draw();
        this.arrange();
        this.size();
        _bInitialized = true;
    } // End of the function
    function set gapi(mcGAPI)
    {
        _mcGAPI = mcGAPI;
        //return (this.gapi());
        null;
    } // End of the function
    function get gapi()
    {
        if (_mcGAPI == undefined)
        {
            return (_parent.gapi);
        }
        else
        {
            return (_mcGAPI);
        } // end else if
    } // End of the function
    function get className()
    {
        return (_sClassName);
    } // End of the function
    function set enabled(bEnabled)
    {
        _bEnabled = bEnabled;
        this.addToQueue({object: this, method: setEnabled});
        //return (this.enabled());
        null;
    } // End of the function
    function get enabled()
    {
        return (_bEnabled);
    } // End of the function
    function set styleName(sStyleName)
    {
        _sStyleName = sStyleName;
        if (_bInitialized && sStyleName != "none" && sStyleName != undefined)
        {
            this.draw();
        } // end if
        //return (this.styleName());
        null;
    } // End of the function
    function get styleName()
    {
        var _loc3 = _sStyleName;
        if (_loc3.length == 0 || _loc3 == undefined || _loc3 == "default")
        {
            for (var _loc2 = _parent; !(_loc2 instanceof ank.gapi.core.UIBasicComponent) && _loc2 != undefined; _loc2 = _loc2._parent)
            {
            } // end of for
            _loc3 = _loc2.styleName;
        } // end if
        if (_loc3 == undefined)
        {
            _loc3 = _sClassName;
        } // end if
        return (_loc3);
    } // End of the function
    function set width(nWidth)
    {
        this.setSize(nWidth, null);
        //return (this.width());
        null;
    } // End of the function
    function get width()
    {
        return (__width);
    } // End of the function
    function set height(nHeight)
    {
        this.setSize(null, nHeight);
        //return (this.height());
        null;
    } // End of the function
    function get height()
    {
        return (__height);
    } // End of the function
    function set params(oParams)
    {
        _oParams = oParams;
        //return (this.params());
        null;
    } // End of the function
    function get params()
    {
        return (_oParams);
    } // End of the function
    function get initialized()
    {
        return (_bInitialized);
    } // End of the function
    function setSize(w, h)
    {
        if (Math.abs(_rotation) == 90)
        {
            var _loc4 = w;
            w = h;
            h = _loc4;
        } // end if
        if (w != undefined && w != null)
        {
            __width = w;
        } // end if
        if (h != undefined && h != null)
        {
            __height = h;
        } // end if
        this.size();
    } // End of the function
    function move(x, y)
    {
        if (x != undefined)
        {
            _x = x;
        } // end if
        if (x != undefined)
        {
            _y = y;
        } // end if
    } // End of the function
    function init(bDontHideBoundingBox, sClassName)
    {
        _sClassName = sClassName;
        if (Math.ceil(_rotation % 180) > 45)
        {
            __width = _height;
            __height = _width;
        }
        else
        {
            __width = _width;
            __height = _height;
        } // end else if
        if (!bDontHideBoundingBox)
        {
            boundingBox_mc._visible = false;
            boundingBox_mc._width = boundingBox_mc._height = 0;
        } // end if
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function getStyle()
    {
        //return (ank.gapi.styles.StylesManager.getStyle(this.styleName()));
    } // End of the function
    function size()
    {
        this.initScale();
    } // End of the function
    function initScale()
    {
        _xscale = _yscale = 100;
    } // End of the function
    function addToQueue(oCall)
    {
        ank.gapi.core.UIBasicComponent._aQueue.push(oCall);
        if (onEnterFrame == undefined)
        {
            onEnterFrame = runQueue;
        } // end if
    } // End of the function
    function runQueue()
    {
        var _loc2 = ank.gapi.core.UIBasicComponent._aQueue.shift();
        _loc2.method.apply(_loc2.object, _loc2.params);
        if (ank.gapi.core.UIBasicComponent._aQueue.length == 0)
        {
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    function drawBorder()
    {
        if (border_mc == undefined)
        {
            this.createEmptyMovieClip("border_mc", 0);
        } // end if
        border_mc.clear();
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 7305079, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(__width, 0);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 9542041, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(__width, __height);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 14015965, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(0, __height);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 9542041, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(0, 0);
        border_mc.moveTo(1, 1);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 13290700, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(__width - 1, 1);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 14015965, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(__width - 1, __height - 1);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 15658734, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(1, __height - 1);
        border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS, 14015965, ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
        border_mc.lineTo(1, 1);
    } // End of the function
    function drawRoundRect(mc, x, y, w, h, r, c, alpha, rot, gradient, ratios)
    {
        var _loc14;
        var _loc17;
        var _loc16;
        var _loc11;
        if (typeof(r) == "object")
        {
            _loc14 = r.br;
            _loc17 = r.bl;
            _loc16 = r.tl;
            _loc11 = r.tr;
        }
        else
        {
            _loc11 = r;
            _loc16 = r;
            _loc17 = r;
            _loc14 = r;
        } // end else if
        if (alpha == undefined)
        {
            alpha = 100;
        } // end if
        if (typeof(c) == "object")
        {
            var _loc9;
            if (typeof(alpha) != "object")
            {
                _loc9 = [alpha, alpha];
            }
            else
            {
                _loc9 = alpha;
            } // end else if
            if (ratios == undefined)
            {
                ratios = [0, 255];
            } // end if
            var _loc15 = h * 7.000000E-001;
            var _loc10;
            if (typeof(rot) != "object")
            {
                _loc10 = {matrixType: "box", x: -_loc15, y: _loc15, w: w * 2, h: h * 4, r: rot * 1.745329E-002};
            }
            else
            {
                _loc10 = rot;
            } // end else if
            if (gradient == "radial")
            {
                mc.beginGradientFill("radial", c, _loc9, ratios, _loc10);
            }
            else
            {
                mc.beginGradientFill("linear", c, _loc9, ratios, _loc10);
            } // end else if
        }
        else if (c != undefined)
        {
            mc.beginFill(c, alpha);
        } // end else if
        r = _loc14;
        if (r != 0)
        {
            var _loc13 = r - r * 7.071068E-001;
            var _loc12 = r - r * 4.142136E-001;
            mc.moveTo(x + w, y + h - r);
            mc.lineTo(x + w, y + h - r);
            mc.curveTo(x + w, y + h - _loc12, x + w - _loc13, y + h - _loc13);
            mc.curveTo(x + w - _loc12, y + h, x + w - r, y + h);
        }
        else
        {
            mc.moveTo(x + w, y + h);
        } // end else if
        r = _loc17;
        if (r != 0)
        {
            _loc13 = r - r * 7.071068E-001;
            _loc12 = r - r * 4.142136E-001;
            mc.lineTo(x + r, y + h);
            mc.curveTo(x + _loc12, y + h, x + _loc13, y + h - _loc13);
            mc.curveTo(x, y + h - _loc12, x, y + h - r);
        }
        else
        {
            mc.lineTo(x, y + h);
        } // end else if
        r = _loc16;
        if (r != 0)
        {
            _loc13 = r - r * 7.071068E-001;
            _loc12 = r - r * 4.142136E-001;
            mc.lineTo(x, y + r);
            mc.curveTo(x, y + _loc12, x + _loc13, y + _loc13);
            mc.curveTo(x + _loc12, y, x + r, y);
        }
        else
        {
            mc.lineTo(x, y);
        } // end else if
        r = _loc11;
        if (r != 0)
        {
            _loc13 = r - r * 7.071068E-001;
            _loc12 = r - r * 4.142136E-001;
            mc.lineTo(x + w - r, y);
            mc.curveTo(x + w - _loc12, y, x + w - _loc13, y + _loc13);
            mc.curveTo(x + w, y + _loc12, x + w, y + r);
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
    } // End of the function
    function setMovieClipColor(mc, nColor)
    {
        var _loc1 = new Color(mc);
        _loc1.setRGB(nColor);
        if (nColor == -1)
        {
            mc._alpha = 0;
        } // end if
    } // End of the function
    function setMovieClipTransform(mc, oTransformation)
    {
        var _loc1 = new Color(mc);
        _loc1.setTransform(oTransformation);
    } // End of the function
    static var BORDER_TICKNESS = 1;
    static var BORDER_ALPHA = 50;
    static var _aQueue = new Array();
    var _bInitialized = false;
    var _sStyleName = "default";
    var _bEnabled = true;
} // End of Class
#endinitclip
