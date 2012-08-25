// Action script...

// [Initial MovieClip Action of sprite 20796]
#initclip 61
if (!ank.gapi.controls.ChatArea)
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
    var _loc1 = (_global.ank.gapi.controls.ChatArea = function ()
    {
        super();
    }).prototype;
    _loc1.__set__selectable = function (bSelectable)
    {
        this._bSelectable = bSelectable;
        if (this._bInitialized)
        {
            this.addToQueue({object: this, method: this.setTextFieldProperties});
        } // end if
        //return (this.selectable());
    };
    _loc1.__get__selectable = function ()
    {
        return (this._bSelectable);
    };
    _loc1.__set__wordWrap = function (bWordWrap)
    {
        this._bWordWrap = bWordWrap;
        if (this._bInitialized)
        {
            this.addToQueue({object: this, method: this.setTextFieldProperties});
        } // end if
        //return (this.wordWrap());
    };
    _loc1.__get__wordWrap = function ()
    {
        return (this._bWordWrap);
    };
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        if (this.initialized)
        {
            this.setTextFieldProperties();
        } // end if
        //return (this.text());
    };
    _loc1.__get__text = function ()
    {
        return (this._tText.text);
    };
    _loc1.__get__htmlText = function ()
    {
        return (this._tText.htmlText);
    };
    _loc1.__set__scrollBarSide = function (sScrollBarSide)
    {
        this._sScrollBarSide = sScrollBarSide;
        //return (this.scrollBarSide());
    };
    _loc1.__get__scrollBarSide = function ()
    {
        return (this._sScrollBarSide);
    };
    _loc1.__set__scrollBarMargin = function (nScrollBarMargin)
    {
        this._nScrollBarMargin = nScrollBarMargin;
        //return (this.scrollBarMargin());
    };
    _loc1.__get__scrollBarMargin = function ()
    {
        return (this._nScrollBarMargin);
    };
    _loc1.__set__hideScrollBar = function (bHideScrollBar)
    {
        this._bHideScrollBar = bHideScrollBar;
        //return (this.hideScrollBar());
    };
    _loc1.__get__hideScrollBar = function ()
    {
        return (this._bHideScrollBar);
    };
    _loc1.__set__useMouseWheel = function (bUseMouseWheel)
    {
        this._bUseMouseWheel = bUseMouseWheel;
        //return (this.useMouseWheel());
    };
    _loc1.__get__useMouseWheel = function ()
    {
        return (this._bUseMouseWheel);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ChatArea.CLASS_NAME);
        this._tfFormatter = new TextFormat();
    };
    _loc1.createChildren = function ()
    {
        this.createTextField("_tText", 10, 0, 0, this.__width - 2, this.__height - 2);
        this._tText._x = 1;
        this._tText._y = 1;
        this._tText.addListener(this);
        this._tText.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this._tText.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
        this._tText.mouseWheelEnabled = true;
        this.addToQueue({object: this, method: this.setTextFieldProperties});
        ank.utils.MouseEvents.addListener(this);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._tText._height = this.__height;
        this._tText._width = this.__width;
        this._bInvalidateMaxScrollStop = true;
        this.setTextFieldProperties();
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._tfFormatter = new TextFormat();
        this._tfFormatter.font = _loc2.font;
        this._tfFormatter.align = _loc2.align;
        this._tfFormatter.size = _loc2.size;
        this._tfFormatter.color = _loc2.color;
        this._tfFormatter.bold = _loc2.bold;
        this._tfFormatter.italic = _loc2.italic;
        this._tText.embedFonts = _loc2.embedfonts;
        this._tText.antiAliasType = _loc2.antialiastype;
        this._sbVertical.styleName = _loc2.scrollbarstyle;
        if (_loc2.filters != undefined)
        {
            this._tText.filters = _loc2.filters;
        } // end if
    };
    _loc1.setTextFieldProperties = function ()
    {
        if (this._tText != undefined)
        {
            this._tText.wordWrap = this._bWordWrap ? (true) : (false);
            this._tText.multiline = true;
            this._tText.selectable = this._bSelectable;
            this._tText.embedFonts = this.getStyle().embedfonts;
            this._tText.type = "dynamic";
            this._tText.html = true;
            if (this._tfFormatter.font != undefined)
            {
                if (this._sText != undefined)
                {
                    this._nPreviousMaxscroll = this._tText.maxscroll;
                    this.setTextWithBottomStart();
                } // end if
                this._tText.setNewTextFormat(this._tfFormatter);
                this._tText.setTextFormat(this._tfFormatter);
            } // end if
            this.onChanged();
        } // end if
    };
    _loc1.addScrollBar = function ()
    {
        if (this._sbVertical == undefined)
        {
            this.attachMovie("ScrollBar", "_sbVertical", 20, {styleName: this.getStyle().scrollbarstyle, _visible: !this._bHideScrollBar});
            this._sbVertical.addEventListener("scroll", this);
        } // end if
        this._sbVertical.setSize(this.__height - 2);
        this._sbVertical._y = 1;
        this._sbVertical._x = this._sScrollBarSide == "right" ? (this.__width - this._sbVertical._width - 3) : (0);
        if (this._bHideScrollBar)
        {
            this._tText._width = this.__width;
            this._tText._x = 0;
        }
        else
        {
            this._tText._width = this.__width - this._sbVertical._width - 3 - this._nScrollBarMargin;
            this._tText._x = this._sScrollBarSide == "right" ? (0) : (this._sbVertical._width + this._nScrollBarMargin);
        } // end else if
        this.setScrollBarPosition();
        if (Math.abs(this._nPreviousMaxscroll - this._tText.scroll) < ank.gapi.controls.ChatArea.STOP_SCROLL_LENGTH || this._bInvalidateMaxScrollStop)
        {
            this._tText.scroll = this._tText.maxscroll;
        } // end if
        this._bInvalidateMaxScrollStop = false;
    };
    _loc1.setScrollBarPosition = function ()
    {
        var _loc2 = this._tText.textHeight;
        var _loc3 = 9.000000E-001 * this._tText._height / _loc2 * this._tText.maxscroll;
        this._sbVertical.setScrollProperties(_loc3, 0, this._tText.maxscroll);
        this._sbVertical.scrollPosition = this._tText.scroll;
    };
    _loc1.setTextWithBottomStart = function ()
    {
        this._tText.text = "";
        for (var _loc2 = 0; this._tText.maxscroll == 1 && _loc2 < 50; ++_loc2)
        {
            this._tText.text = this._tText.text + "\n";
        } // end of for
        this._tText.htmlText = this._tText.htmlText + this._sText;
    };
    _loc1.onMouseWheel = function (nDelta, mc)
    {
        if (!this._bUseMouseWheel)
        {
            return;
        } // end if
        if (String(mc._target).indexOf(this._target) != -1)
        {
            this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - nDelta;
        } // end if
    };
    _loc1.onChanged = function ()
    {
        this.addScrollBar();
    };
    _loc1.onScroller = function ()
    {
        this.setScrollBarPosition();
    };
    _loc1.scroll = function (oEvent)
    {
        if (oEvent.target == this._sbVertical)
        {
            this._tText.scroll = oEvent.target.scrollPosition;
        } // end if
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
    _loc1.addProperty("scrollBarMargin", _loc1.__get__scrollBarMargin, _loc1.__set__scrollBarMargin);
    _loc1.addProperty("useMouseWheel", _loc1.__get__useMouseWheel, _loc1.__set__useMouseWheel);
    _loc1.addProperty("scrollBarSide", _loc1.__get__scrollBarSide, _loc1.__set__scrollBarSide);
    _loc1.addProperty("htmlText", _loc1.__get__htmlText, function ()
    {
    });
    _loc1.addProperty("selectable", _loc1.__get__selectable, _loc1.__set__selectable);
    _loc1.addProperty("hideScrollBar", _loc1.__get__hideScrollBar, _loc1.__set__hideScrollBar);
    _loc1.addProperty("wordWrap", _loc1.__get__wordWrap, _loc1.__set__wordWrap);
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ChatArea = function ()
    {
        super();
    }).CLASS_NAME = "ChatArea";
    (_global.ank.gapi.controls.ChatArea = function ()
    {
        super();
    }).STOP_SCROLL_LENGTH = 6;
    _loc1._bSelectable = false;
    _loc1._bWordWrap = true;
    _loc1._sScrollBarSide = "right";
    _loc1._nScrollBarMargin = 0;
    _loc1._bHideScrollBar = false;
    _loc1._bUseMouseWheel = true;
    _loc1._bInvalidateMaxScrollStop = false;
    _loc1._nPreviousMaxscroll = 1;
} // end if
#endinitclip
