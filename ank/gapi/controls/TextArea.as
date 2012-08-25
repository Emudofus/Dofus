// Action script...

// [Initial MovieClip Action of sprite 20582]
#initclip 103
if (!ank.gapi.controls.TextArea)
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
    var _loc1 = (_global.ank.gapi.controls.TextArea = function ()
    {
        super();
    }).prototype;
    _loc1.__set__border = function (bBorder)
    {
        this._bBorder = bBorder;
        if (this.border_mc == undefined)
        {
            this.drawBorder();
        } // end if
        this.border_mc._visible = bBorder;
        //return (this.border());
    };
    _loc1.__get__border = function ()
    {
        return (this._bBorder);
    };
    _loc1.__set__url = function (sURL)
    {
        this._sURL = sURL;
        if (this._sURL != "")
        {
            this.loadText();
        } // end if
        //return (this.url());
    };
    _loc1.__set__editable = function (bEditable)
    {
        this._bEditable = bEditable;
        if (this._bInitialized)
        {
            this.addToQueue({object: this, method: this.setTextFieldProperties});
        } // end if
        //return (this.editable());
    };
    _loc1.__get__editable = function ()
    {
        return (this._bEditable);
    };
    _loc1.__set__autoHeight = function (bAutoHeight)
    {
        this._bAutoHeight = bAutoHeight;
        if (this._bInitialized)
        {
            this.addToQueue({object: this, method: this.setTextFieldProperties});
        } // end if
        //return (this.autoHeight());
    };
    _loc1.__get__autoHeight = function ()
    {
        return (this._bAutoHeight);
    };
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
    _loc1.__set__html = function (bHTML)
    {
        this._bHTML = bHTML;
        if (this._bInitialized)
        {
            this.addToQueue({object: this, method: this.setTextFieldProperties});
        } // end if
        //return (this.html());
    };
    _loc1.__get__html = function ()
    {
        return (this._bHTML);
    };
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        this._bSettingNewText = true;
        this.addToQueue({object: this, method: this.setTextFieldProperties});
        //return (this.text());
    };
    _loc1.__get__text = function ()
    {
        return (this._tText.text);
    };
    _loc1.__set__scrollBarRight = function (bScrollBarRight)
    {
        this._bScrollBarRight = bScrollBarRight;
        //return (this.scrollBarRight());
    };
    _loc1.__get__scrollBarRight = function ()
    {
        return (this._bScrollBarRight);
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
    _loc1.__set__styleSheet = function (sCSS)
    {
        if (sCSS != "")
        {
            var _owner = this;
            this._cssStyles = new TextField.StyleSheet();
            this._cssStyles.load(sCSS);
            this._cssStyles.onLoad = function (bSuccess)
            {
                if (_owner._tText != undefined)
                {
                    _owner.addToQueue({object: _owner, method: _owner.setTextFieldProperties});
                } // end if
            };
        }
        else
        {
            this._cssStyles = undefined;
            this._tText.styleSheet = null;
        } // end else if
        //return (this.styleSheet());
    };
    _loc1.__set__scrollPosition = function (nScrollPosition)
    {
        this._tText.scroll = nScrollPosition;
        //return (this.scrollPosition());
    };
    _loc1.__get__scrollPosition = function ()
    {
        return (this._tText.scroll);
    };
    _loc1.__set__maxscroll = function (nMaxScroll)
    {
        this._tText.maxscroll = nMaxScroll;
        //return (this.maxscroll());
    };
    _loc1.__get__maxscroll = function ()
    {
        return (this._tText.maxscroll);
    };
    _loc1.__set__maxChars = function (nMaxChars)
    {
        this._tText.maxChars = nMaxChars;
        //return (this.maxChars());
    };
    _loc1.__get__maxChars = function ()
    {
        return (this._tText.maxChars);
    };
    _loc1.__get__textHeight = function ()
    {
        return (this._tText.textHeight);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.TextArea.CLASS_NAME);
        if (this._sURL != undefined)
        {
            this.loadText();
        } // end if
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
        ank.utils.MouseEvents.addListener(this);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        this._sbVertical.setSize(this.__height);
        this._tText._height = this.__height;
        this._tText._width = this.__width;
    };
    _loc1.draw = function ()
    {
        if (this._bBorder)
        {
            this.drawBorder();
        } // end if
        if (!this._bBorder != undefined)
        {
            this.border_mc._visible = this._bBorder;
        } // end if
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
    };
    _loc1.loadText = function ()
    {
        if (this._sURL == undefined || this._sURL == "")
        {
            return;
        } // end if
        this._lvText = new LoadVars();
        this._lvText.parent = this;
        this._lvText.onData = function (sData)
        {
            this.parent.text = sData;
        };
        this._lvText.load(this._sURL);
    };
    _loc1.setTextFieldProperties = function ()
    {
        if (this._tText != undefined)
        {
            if (this._bAutoHeight)
            {
                this._tText.autoSize = "left";
            } // end if
            this._tText.wordWrap = this._bWordWrap ? (true) : (false);
            this._tText.multiline = true;
            this._tText.selectable = this._bSelectable;
            this._tText.type = this._bEditable ? ("input") : ("dynamic");
            this._tText.html = this._bHTML;
            if (this._cssStyles != undefined)
            {
                this._tText.styleSheet = this._cssStyles;
                if (this._sText != undefined)
                {
                    if (this._bHTML)
                    {
                        this._tText.htmlText = this._sText;
                    }
                    else
                    {
                        this._tText.text = this._sText;
                    } // end if
                } // end else if
            }
            else if (this._tfFormatter.font != undefined)
            {
                if (this._sText != undefined)
                {
                    if (this._bHTML)
                    {
                        this._tText.htmlText = this._sText;
                    }
                    else
                    {
                        this._tText.text = this._sText;
                    } // end if
                } // end else if
                this._tText.setNewTextFormat(this._tfFormatter);
                this._tText.setTextFormat(this._tfFormatter);
            } // end else if
            this.onChanged();
        } // end if
    };
    _loc1.addScrollBar = function ()
    {
        if (this._sbVertical == undefined)
        {
            this.attachMovie("ScrollBar", "_sbVertical", 20, {styleName: this.getStyle().scrollbarstyle});
            this._sbVertical.setSize(this.__height - 2);
            this._sbVertical._y = 1;
            this._sbVertical._x = this._bScrollBarRight ? (this.__width - this._sbVertical._width - 3) : (0);
            this._tText._width = this.__width - this._sbVertical._width - 3 - this._nScrollBarMargin;
            this._tText._x = this._bScrollBarRight ? (0) : (this._sbVertical._width + this._nScrollBarMargin);
            this._sbVertical.addEventListener("scroll", this);
        } // end if
        var _loc2 = this._tText.textHeight;
        var _loc3 = 9.000000E-001 * this._tText._height / _loc2 * this._tText.maxscroll;
        this._sbVertical.setScrollProperties(_loc3, 0, this._tText.maxscroll);
        this._sbVertical.scrollPosition = this._tText.scroll;
        if (this._bSettingNewText)
        {
            this._sbVertical.scrollPosition = 0;
            this._bSettingNewText = false;
        } // end if
    };
    _loc1.removeScrollBar = function ()
    {
        if (this._sbVertical != undefined)
        {
            this._sbVertical.removeMovieClip();
            this._tText._width = this.__width;
        } // end if
    };
    _loc1.onChanged = function ()
    {
        if (this._tText.textHeight >= this._tText._height || this._cssStyles != undefined && this._tText.textHeight + 5 >= this._tText._height)
        {
            this.addScrollBar();
        }
        else
        {
            this.removeScrollBar();
        } // end else if
        if (this._bAutoHeight && this._tText.textHeight != this.__height)
        {
            this.setSize(this.__width, this._tText.textHeight);
            this.dispatchEvent({type: "resize"});
        } // end if
        this.dispatchEvent({type: "change"});
    };
    _loc1.scroll = function (oEvent)
    {
        if (oEvent.target == this._sbVertical)
        {
            this._tText.scroll = oEvent.target.scrollPosition;
        } // end if
    };
    _loc1.onMouseWheel = function (nDelta, mc)
    {
        if (String(mc._target).indexOf(this._target) != -1)
        {
            this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - nDelta;
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
    _loc1.addProperty("scrollPosition", _loc1.__get__scrollPosition, _loc1.__set__scrollPosition);
    _loc1.addProperty("selectable", _loc1.__get__selectable, _loc1.__set__selectable);
    _loc1.addProperty("border", _loc1.__get__border, _loc1.__set__border);
    _loc1.addProperty("scrollBarRight", _loc1.__get__scrollBarRight, _loc1.__set__scrollBarRight);
    _loc1.addProperty("wordWrap", _loc1.__get__wordWrap, _loc1.__set__wordWrap);
    _loc1.addProperty("editable", _loc1.__get__editable, _loc1.__set__editable);
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    _loc1.addProperty("autoHeight", _loc1.__get__autoHeight, _loc1.__set__autoHeight);
    _loc1.addProperty("styleSheet", function ()
    {
    }, _loc1.__set__styleSheet);
    _loc1.addProperty("maxChars", _loc1.__get__maxChars, _loc1.__set__maxChars);
    _loc1.addProperty("maxscroll", _loc1.__get__maxscroll, _loc1.__set__maxscroll);
    _loc1.addProperty("html", _loc1.__get__html, _loc1.__set__html);
    _loc1.addProperty("textHeight", _loc1.__get__textHeight, function ()
    {
    });
    _loc1.addProperty("url", function ()
    {
    }, _loc1.__set__url);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.TextArea = function ()
    {
        super();
    }).CLASS_NAME = "TextArea";
    _loc1._bEditable = true;
    _loc1._bSelectable = true;
    _loc1._bAutoHeight = false;
    _loc1._bWordWrap = true;
    _loc1._bScrollBarRight = true;
    _loc1._bHTML = false;
    _loc1._nScrollBarMargin = 0;
} // end if
#endinitclip
