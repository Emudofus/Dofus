// Action script...

// [Initial MovieClip Action of sprite 137]
#initclip 7
class ank.gapi.controls.Button extends ank.gapi.core.UIBasicComponent
{
    var __get__label, _bSelected, _lblLabel, _mcIcon, _mcDown, _mcUp, __get__selected, __get__toggle, _sIcon, __get__initialized, __get__icon, __get__backgroundUp, __get__backgroundDown, attachMovie, __set__selected, getStyle, __height, __width, _bEnabled, setMovieClipTransform, _bInitialized, dispatchEvent, __set__backgroundDown, __set__backgroundUp, __set__icon, __get__iconClip, __set__label, __set__toggle;
    function Button()
    {
        super();
    } // End of the function
    function set label(sLabel)
    {
        _sLabel = sLabel;
        this.displayLabel();
        //return (this.label());
        null;
    } // End of the function
    function set selected(bSelected)
    {
        if (_bSelected != bSelected)
        {
            _lblLabel._x = _lblLabel._x + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            _lblLabel._y = _lblLabel._y + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            _mcIcon._x = _mcIcon._x + (bSelected ? (5.000000E-001) : (-5.000000E-001));
            _mcIcon._y = _mcIcon._y + (bSelected ? (5.000000E-001) : (-5.000000E-001));
        } // end if
        _bSelected = bSelected;
        _mcDown._visible = _bSelected;
        _mcUp._visible = !_bSelected;
        this.setLabelStyle();
        //return (this.selected());
        null;
    } // End of the function
    function get selected()
    {
        return (_bSelected);
    } // End of the function
    function set toggle(bToggle)
    {
        _bToggle = bToggle;
        //return (this.toggle());
        null;
    } // End of the function
    function get toggle()
    {
        return (_bToggle);
    } // End of the function
    function set icon(sIcon)
    {
        _sIcon = sIcon;
        if (this.__get__initialized())
        {
            this.displayIcon();
        } // end if
        //return (this.icon());
        null;
    } // End of the function
    function get icon()
    {
        return (_sIcon);
    } // End of the function
    function get iconClip()
    {
        return (_mcIcon);
    } // End of the function
    function set backgroundUp(sBackgroundUp)
    {
        _sBackgroundUp = sBackgroundUp;
        //return (this.backgroundUp());
        null;
    } // End of the function
    function get backgroundUp()
    {
        return (_sBackgroundUp);
    } // End of the function
    function set backgroundDown(sBackgroundDown)
    {
        _sBackgroundDown = sBackgroundDown;
        //return (this.backgroundDown());
        null;
    } // End of the function
    function get backgroundDown()
    {
        return (_sBackgroundDown);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Button.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        super.createChildren();
        if (_sBackgroundDown != "none")
        {
            this.attachMovie(_sBackgroundDown, "_mcDown", 10);
        } // end if
        if (_sBackgroundUp != "none")
        {
            this.attachMovie(_sBackgroundUp, "_mcUp", 20);
        } // end if
        this.__set__selected(_bSelected && _bToggle);
        this.attachMovie("Label", "_lblLabel", 30, {styleName: this.getStyle().labelupstyle});
        _lblLabel.addEventListener("change", this);
        if (_sLabel == undefined)
        {
            _sLabel = "Label";
        } // end if
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        this.setLabelStyle();
        this.displayLabel();
        _mcUp.setStyleColor(_loc2, "color");
        _mcDown.setStyleColor(_loc2, "downcolor");
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        var _loc3 = _mcUp;
        var _loc2 = _mcDown;
        _loc3.setSize(__width, __height, true);
        _loc2.setSize(__width, __height, true);
        this.displayLabel();
        this.displayIcon();
    } // End of the function
    function setEnabled()
    {
        if (!_bEnabled)
        {
            this.setMovieClipTransform(this, this.getStyle().disabledtransform);
        }
        else
        {
            this.setMovieClipTransform(this, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0, aa: 100, ab: 0});
        } // end else if
    } // End of the function
    function displayIcon()
    {
        if (_mcIcon != undefined)
        {
            _mcIcon.removeMovieClip();
        } // end if
        if (_sIcon.length == 0)
        {
            return;
        } // end if
        this.attachMovie(_sIcon, "_mcIcon", 40);
        var _loc2 = _mcIcon.getBounds(this);
        _mcIcon._x = (__width - _mcIcon._width) / 2 - _loc2.xMin;
        _mcIcon._y = (__height - _mcIcon._height) / 2 - _loc2.yMin;
    } // End of the function
    function setLabelStyle(bOver)
    {
        if (_bSelected)
        {
            _lblLabel.__set__styleName(this.getStyle().labeldownstyle);
        }
        else if (bOver == true && this.getStyle().labeloverstyle != undefined)
        {
            _lblLabel.__set__styleName(this.getStyle().labeloverstyle);
        }
        else
        {
            _lblLabel.__set__styleName(this.getStyle().labelupstyle);
        } // end else if
    } // End of the function
    function displayLabel()
    {
        _lblLabel.__set__text(_sLabel);
        if (_bInitialized)
        {
            this.placeLabel();
        } // end if
    } // End of the function
    function placeLabel()
    {
        if (_sLabel.length == 0)
        {
            _lblLabel._visible = false;
        }
        else
        {
            _lblLabel._visible = true;
            _lblLabel._x = (__width - _lblLabel._width) / 2;
            _lblLabel._y = (__height - _lblLabel.__get__textHeight()) / 2 - 4;
        } // end else if
        _lblLabel.setSize(__width, _lblLabel.__get__textHeight() + 4);
    } // End of the function
    function change(oEvent)
    {
        this.placeLabel();
    } // End of the function
    function onPress()
    {
        if (!this.__get__selected() && !_bToggle)
        {
            this.__set__selected(true);
        }
        else if (_bToggle && !this.__get__selected())
        {
            _mcUp._visible = false;
            _mcDown._visible = true;
        } // end else if
    } // End of the function
    function onRelease()
    {
        if (_bToggle)
        {
            this.__set__selected(!this.__get__selected());
        }
        else
        {
            this.__set__selected(false);
        } // end else if
        this.dispatchEvent({type: "click", target: this});
    } // End of the function
    function onReleaseOutside()
    {
        if (_bToggle)
        {
            if (!this.__get__selected())
            {
                _mcUp._visible = true;
                _mcDown._visible = false;
            } // end if
        }
        else
        {
            this.__set__selected(false);
        } // end else if
        this.onRollOut();
    } // End of the function
    function onRollOver()
    {
        this.setLabelStyle(true);
        this.dispatchEvent({type: "over", target: this});
    } // End of the function
    function onRollOut()
    {
        this.setLabelStyle(false);
        this.dispatchEvent({type: "out", target: this});
    } // End of the function
    static var CLASS_NAME = "Button";
    var _bToggle = false;
    var _sLabel = "";
    var _sBackgroundUp = "ButtonNormalUp";
    var _sBackgroundDown = "ButtonNormalDown";
} // End of Class
#endinitclip
