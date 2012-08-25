// Action script...

// [Initial MovieClip Action of sprite 20677]
#initclip 198
if (!ank.gapi.controls.Label)
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
    var _loc1 = (_global.ank.gapi.controls.Label = function ()
    {
        super();
    }).prototype;
    _loc1.__set__html = function (bHTML)
    {
        this._bHTML = bHTML;
        this.setTextFieldProperties();
        //return (this.html());
    };
    _loc1.__get__html = function ()
    {
        return (this._bHTML);
    };
    _loc1.__set__multiline = function (bMultiline)
    {
        this._bMultiline = bMultiline;
        this.setTextFieldProperties();
        //return (this.multiline());
    };
    _loc1.__get__multiline = function ()
    {
        return (this._bMultiline);
    };
    _loc1.__set__wordWrap = function (bWordWrap)
    {
        this._bWordWrap = bWordWrap;
        this.setTextFieldProperties();
        //return (this.wordWrap());
    };
    _loc1.__get__wordWrap = function ()
    {
        return (this._bWordWrap);
    };
    _loc1.__set__text = function (sText)
    {
        this._sText = sText;
        this._bSettingNewText = true;
        this.setTextFieldProperties();
        //return (this.text());
    };
    _loc1.__get__text = function ()
    {
        return (this._tText.text == undefined ? (this._sText) : (this._tText.text));
    };
    _loc1.__get__textHeight = function ()
    {
        return (this._tText.textHeight);
    };
    _loc1.__get__textWidth = function ()
    {
        return (this._tText.textWidth);
    };
    _loc1.__set__textColor = function (nColor)
    {
        this._tText.textColor = nColor;
        //return (this.textColor());
    };
    _loc1.setPreferedSize = function (sAutoSizeAlign)
    {
        this._tText.autoSize = sAutoSizeAlign;
        this.setSize(this.textWidth + 5, this.textHeight);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Label.CLASS_NAME);
        this._tfFormatter = new TextFormat();
    };
    _loc1.createChildren = function ()
    {
        this.createTextField("_tText", 10, 0, 1, this.__width, this.__height - 1);
        this._tText.addListener(this);
        this._tText.onKillFocus = function ()
        {
            this._parent.onKillFocus();
        };
        this._tText.onSetFocus = function ()
        {
            this._parent.onSetFocus();
        };
        this.setTextFieldProperties();
    };
    _loc1.size = function ()
    {
        super.size();
        this._tText._height = this.__height - 1;
        this._tDotText.removeTextField();
        this._mcDot.removeMovieClip();
        if (this._tText.textWidth > this.__width && this._sTextfiledType == "dynamic")
        {
            this.createTextField("_tDotText", 20, 0, 1, this.__width, this.__height - 1);
            this._tDotText.selectable = false;
            this._tDotText.autoSize = "right";
            this._tDotText.embedFonts = this.getStyle().labelembedfonts;
            this._tDotText.text = "...";
            this._tDotText.setNewTextFormat(this._tfFormatter);
            this._tDotText.setTextFormat(this._tfFormatter);
            this._tText._width = this.__width - this._tDotText.textWidth;
            this.createEmptyMovieClip("_mcDot", 30);
            this.drawRoundRect(this._mcDot, this.__width - this._tDotText.textWidth, 0, this._tDotText.textWidth + 5, this.__height, 0, 0, 0);
            this._mcDot.onRollOver = function ()
            {
                this._parent.gapi.showTooltip(this._parent._sText, this._parent, 0);
            };
            this._mcDot.onRollOut = function ()
            {
                this._parent.gapi.hideTooltip();
            };
        }
        else
        {
            this._tText._width = this.__width;
        } // end else if
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._tfFormatter = this._tText.getTextFormat();
        this._tfFormatter.font = _loc2.labelfont;
        this._tfFormatter.align = _loc2.labelalign;
        this._tfFormatter.size = _loc2.labelsize;
        if (!this._bHTML)
        {
            this._tfFormatter.color = _loc2.labelcolor;
        } // end if
        this._tfFormatter.bold = _loc2.labelbold;
        this._tfFormatter.italic = _loc2.labelitalic;
        this._tText.embedFonts = _loc2.labelembedfonts;
        this._tText.antiAliasType = _loc2.antialiastype;
        this.setTextFieldProperties();
    };
    _loc1.setTextFieldProperties = function ()
    {
        if (this._tText != undefined)
        {
            this._tText.wordWrap = this._bWordWrap;
            this._tText.multiline = this._bMultiline;
            this._tText.selectable = this._sTextfiledType == "input";
            this._tText.type = this._sTextfiledType;
            this._tText.html = this._bHTML ? (true) : (false);
            if (this._tfFormatter.font != undefined)
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
            } // end if
            if (this._tText.textWidth > this.__width && this._sTextfiledType == "dynamic")
            {
                this.size();
            }
            else
            {
                this._tDotText.removeTextField();
                this._mcDot.removeMovieClip();
            } // end else if
            this.onChanged();
        } // end if
    };
    _loc1.onChanged = function ()
    {
        this.dispatchEvent({type: "change"});
    };
    _loc1.onSetFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "false");
    };
    _loc1.onKillFocus = function ()
    {
        getURL("FSCommand:" add "trapallkeys", "true");
    };
    _loc1.addProperty("text", _loc1.__get__text, _loc1.__set__text);
    _loc1.addProperty("html", _loc1.__get__html, _loc1.__set__html);
    _loc1.addProperty("textWidth", _loc1.__get__textWidth, function ()
    {
    });
    _loc1.addProperty("textHeight", _loc1.__get__textHeight, function ()
    {
    });
    _loc1.addProperty("wordWrap", _loc1.__get__wordWrap, _loc1.__set__wordWrap);
    _loc1.addProperty("multiline", _loc1.__get__multiline, _loc1.__set__multiline);
    _loc1.addProperty("textColor", function ()
    {
    }, _loc1.__set__textColor);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Label = function ()
    {
        super();
    }).CLASS_NAME = "Label";
    _loc1._sTextfiledType = "dynamic";
    _loc1._bMultiline = false;
    _loc1._bWordWrap = false;
    _loc1.bDisplayDebug = false;
} // end if
#endinitclip
