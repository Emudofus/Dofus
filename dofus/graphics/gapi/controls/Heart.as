// Action script...

// [Initial MovieClip Action of sprite 20751]
#initclip 16
if (!dofus.graphics.gapi.controls.Heart)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.Heart = function ()
    {
        super();
    }).prototype;
    _loc1.__set__value = function (nValue)
    {
        nValue = Number(nValue);
        if (_global.isNaN(nValue))
        {
            return;
        } // end if
        this._nValue = nValue;
        if (this._nMax != undefined)
        {
            this.applyValue();
        } // end if
        //return (this.value());
    };
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.__set__max = function (nMax)
    {
        nMax = Number(nMax);
        if (_global.isNaN(nMax))
        {
            return;
        } // end if
        this._nMax = nMax;
        if (this._nValue != undefined)
        {
            this.applyValue();
        } // end if
        //return (this.max());
    };
    _loc1.__get__max = function ()
    {
        return (this._nMax);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.Heart.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._nMaxHeight = this._mcRectangle._height;
        this._nDisplayState = 0;
        this.stop();
    };
    _loc1.applyValue = function ()
    {
        switch (this._nDisplayState)
        {
            case 1:
            {
                this._txtCurrent.text = String(this._nValue);
                this._txtMax.text = String(this._nMax);
                break;
            } 
            case 2:
            {
                this._txtPercent.text = String(Math.round(this._nValue / this._nMax * 100));
                break;
            } 
            default:
            {
                this._txtValue.text = String(this._nValue);
                break;
            } 
        } // End of switch
        this._mcRectangle._height = this._nValue / this._nMax * this._nMaxHeight;
    };
    _loc1.toggleDisplay = function ()
    {
        ++this._nDisplayState;
        if (this._nDisplayState > 2)
        {
            this._nDisplayState = 0;
        } // end if
        this._nDisplayState = Number(this._nDisplayState);
        if (_global.isNaN(this._nDisplayState))
        {
            this._nDisplayState = 0;
        } // end if
        switch (this._nDisplayState)
        {
            case 1:
            {
                this.gotoAndStop("Double");
                break;
            } 
            case 2:
            {
                this.gotoAndStop("Percent");
                break;
            } 
            default:
            {
                this.gotoAndStop("Value");
                break;
            } 
        } // End of switch
        this.addToQueue({object: this, method: this.applyValue});
    };
    _loc1.addProperty("max", _loc1.__get__max, _loc1.__set__max);
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.Heart = function ()
    {
        super();
    }).CLASS_NAME = "Heart";
} // end if
#endinitclip
