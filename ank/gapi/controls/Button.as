// Action script...

// [Initial MovieClip Action of sprite 20979]
#initclip 244
if (!ank.gapi.controls.Button)
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
    var _loc1 = (_global.ank.gapi.controls.Button = function ()
    {
        super();
    }).prototype;
    _loc1.__set__label = function (sLabel)
    {
        this._sLabel = sLabel;
        this.displayLabel();
        //return (this.label());
    };
    _loc1.__set__selected = function (bSelected)
    {
        if (this._bSelected != bSelected)
        {
            this._lblLabel._x = this._lblLabel._x + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            this._lblLabel._y = this._lblLabel._y + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            this._mcIcon._x = this._mcIcon._x + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            this._mcIcon._y = this._mcIcon._y + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            this.dispatchEvent({type: "stateChanged", target: this, value: bSelected});
        } // end if
        this._bSelected = bSelected;
        this._mcDown._visible = this._bSelected;
        this._mcUp._visible = !this._bSelected;
        this.setLabelStyle();
        //return (this.selected());
    };
    _loc1.__get__selected = function ()
    {
        return (this._bSelected);
    };
    _loc1.__set__toggle = function (bToggle)
    {
        this._bToggle = bToggle;
        //return (this.toggle());
    };
    _loc1.__get__toggle = function ()
    {
        return (this._bToggle);
    };
    _loc1.__set__radio = function (bRadio)
    {
        this._bRadio = bRadio;
        //return (this.radio());
    };
    _loc1.__get__radio = function ()
    {
        return (this._bRadio);
    };
    _loc1.__set__icon = function (sIcon)
    {
        this._sIcon = sIcon;
        if (this.initialized)
        {
            this.displayIcon();
        } // end if
        //return (this.icon());
    };
    _loc1.__get__icon = function ()
    {
        return (this._sIcon);
    };
    _loc1.__get__iconClip = function ()
    {
        return (this._mcIcon);
    };
    _loc1.__set__backgroundUp = function (sBackgroundUp)
    {
        this._sBackgroundUp = sBackgroundUp;
        if (this.initialized)
        {
            this.drawBackgrounds();
        } // end if
        //return (this.backgroundUp());
    };
    _loc1.__get__backgroundUp = function ()
    {
        return (this._sBackgroundUp);
    };
    _loc1.__set__backgroundDown = function (sBackgroundDown)
    {
        this._sBackgroundDown = sBackgroundDown;
        if (this.initialized)
        {
            this.drawBackgrounds();
        } // end if
        //return (this.backgroundDown());
    };
    _loc1.__get__backgroundDown = function ()
    {
        return (this._sBackgroundDown);
    };
    _loc1.setPreferedSize = function (nLabelPadding)
    {
        if (this._sLabel != "")
        {
            if (_global.isNaN(Number(nLabelPadding)))
            {
                this._nLabelPadding = 0;
            }
            else
            {
                this._nLabelPadding = Number(nLabelPadding);
            } // end else if
            this._lblLabel.setPreferedSize("left");
            this.setSize(this._lblLabel.width + this._nLabelPadding * 2);
        } // end if
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Button.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        super.createChildren();
        this.drawBackgrounds();
        this.selected = this._bSelected && this._bToggle;
        this.attachMovie("Label", "_lblLabel", 30, {styleName: this.getStyle().labelupstyle});
        this._lblLabel.addEventListener("change", this);
        if (this._sLabel == undefined)
        {
            this._sLabel = "Label";
        } // end if
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this.setLabelStyle();
        this.displayLabel();
        this._mcUp.setStyleColor(_loc2, "color");
        this._mcDown.setStyleColor(_loc2, "downcolor");
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        var _loc2 = this._mcUp;
        var _loc3 = this._mcDown;
        _loc2.setSize(this.__width, this.__height, true);
        _loc3.setSize(this.__width, this.__height, true);
        this.displayLabel();
        this.displayIcon();
    };
    _loc1.setEnabled = function ()
    {
        if (!this._bEnabled)
        {
            this.setMovieClipTransform(this, this.getStyle().disabledtransform);
        }
        else
        {
            this.setMovieClipTransform(this, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0});
        } // end else if
    };
    _loc1.drawBackgrounds = function ()
    {
        if (this._sBackgroundDown != "none")
        {
            this.attachMovie(this._sBackgroundDown, "_mcDown", 10);
        } // end if
        if (this._sBackgroundUp != "none")
        {
            this.attachMovie(this._sBackgroundUp, "_mcUp", 20);
        } // end if
    };
    _loc1.displayIcon = function ()
    {
        if (this._mcIcon != undefined)
        {
            this._mcIcon.removeMovieClip();
        } // end if
        if (this._sIcon.length == 0)
        {
            return;
        } // end if
        this.attachMovie(this._sIcon, "_mcIcon", 40);
        var _loc2 = this._mcIcon.getBounds(this);
        this._mcIcon._x = (this.__width - this._mcIcon._width) / 2 - _loc2.xMin;
        this._mcIcon._y = (this.__height - this._mcIcon._height) / 2 - _loc2.yMin;
    };
    _loc1.setLabelStyle = function (bOver)
    {
        if (this._bSelected)
        {
            this._lblLabel.styleName = this.getStyle().labeldownstyle;
        }
        else if (bOver == true && this.getStyle().labeloverstyle != undefined)
        {
            this._lblLabel.styleName = this.getStyle().labeloverstyle;
        }
        else
        {
            this._lblLabel.styleName = this.getStyle().labelupstyle;
        } // end else if
    };
    _loc1.displayLabel = function ()
    {
        this._lblLabel.text = this._sLabel;
        if (this._bInitialized)
        {
            this.placeLabel();
        } // end if
    };
    _loc1.placeLabel = function ()
    {
        this._lblLabel.setSize(this.__width - 2 * this._nLabelPadding, this._lblLabel.textHeight + 4);
        if (this._sLabel.length == 0)
        {
            this._lblLabel._visible = false;
        }
        else
        {
            this._lblLabel._visible = true;
            this._lblLabel._x = (this.__width - this._lblLabel.width) / 2;
            this._lblLabel._y = (this.__height - this._lblLabel.textHeight) / 2 - 4;
        } // end else if
    };
    _loc1.change = function (oEvent)
    {
        this.placeLabel();
    };
    _loc1.onPress = function ()
    {
        if (!this.selected && !this._bToggle)
        {
            this.selected = true;
        }
        else if (this._bToggle && !this.selected)
        {
            this._mcUp._visible = false;
            this._mcDown._visible = true;
        } // end else if
    };
    _loc1.onRelease = function ()
    {
        if (this._bRadio)
        {
            this.selected = true;
        }
        else if (this._bToggle)
        {
            this.selected = !this.selected;
        }
        else
        {
            this.selected = false;
        } // end else if
        this.dispatchEvent({type: "click"});
    };
    _loc1.onReleaseOutside = function ()
    {
        if (this._bToggle)
        {
            if (!this.selected)
            {
                this._mcUp._visible = true;
                this._mcDown._visible = false;
            } // end if
        }
        else
        {
            this.selected = false;
        } // end else if
        this.onRollOut();
    };
    _loc1.onRollOver = function ()
    {
        this.setLabelStyle(true);
        this.dispatchEvent({type: "over", target: this});
    };
    _loc1.onRollOut = function ()
    {
        this.setLabelStyle(false);
        this.dispatchEvent({type: "out", target: this});
    };
    _loc1.addProperty("icon", _loc1.__get__icon, _loc1.__set__icon);
    _loc1.addProperty("radio", _loc1.__get__radio, _loc1.__set__radio);
    _loc1.addProperty("toggle", _loc1.__get__toggle, _loc1.__set__toggle);
    _loc1.addProperty("selected", _loc1.__get__selected, _loc1.__set__selected);
    _loc1.addProperty("backgroundDown", _loc1.__get__backgroundDown, _loc1.__set__backgroundDown);
    _loc1.addProperty("label", function ()
    {
    }, _loc1.__set__label);
    _loc1.addProperty("backgroundUp", _loc1.__get__backgroundUp, _loc1.__set__backgroundUp);
    _loc1.addProperty("iconClip", _loc1.__get__iconClip, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Button = function ()
    {
        super();
    }).CLASS_NAME = "Button";
    _loc1._bToggle = false;
    _loc1._bRadio = false;
    _loc1._sLabel = "";
    _loc1._sBackgroundUp = "ButtonNormalUp";
    _loc1._sBackgroundDown = "ButtonNormalDown";
    _loc1._nLabelPadding = 0;
} // end if
#endinitclip
