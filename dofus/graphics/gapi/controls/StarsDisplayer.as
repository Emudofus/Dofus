// Action script...

// [Initial MovieClip Action of sprite 20881]
#initclip 146
if (!dofus.graphics.gapi.controls.StarsDisplayer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.StarsDisplayer = function ()
    {
        super();
    }).prototype;
    _loc1.__get__value = function ()
    {
        return (this._nValue);
    };
    _loc1.__set__value = function (value)
    {
        this._nValue = value;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.value());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.StarsDisplayer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initData = function ()
    {
        this.updateData();
    };
    _loc1.addListeners = function ()
    {
        var ref = this;
        this._mcMask.onRollOut = function ()
        {
            ref.dispatchEvent({type: "out"});
        };
        this._mcMask.onRollOver = function ()
        {
            ref.dispatchEvent({type: "over"});
        };
        this._mcMask.onRelease = function ()
        {
            ref.dispatchEvent({type: "click"});
        };
    };
    _loc1.updateData = function ()
    {
        if (this._nValue != undefined && (this._nValue > 0 && !_global.isNaN(this._nValue)))
        {
            var _loc2 = this.getStarsColor();
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
            {
                var _loc4 = this["_mcStar" + _loc3].fill;
                if (_loc2[_loc3] > -1)
                {
                    var _loc5 = new Color(_loc4);
                    _loc5.setRGB(_loc2[_loc3]);
                    continue;
                } // end if
                _loc4._alpha = 0;
            } // end while
        }
        else
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
            {
                this["_mcStar" + _loc6].fill._alpha = 0;
            } // end while
        } // end else if
    };
    _loc1.getStarsColor = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT)
        {
            var _loc4 = Math.floor(this._nValue / 100) + (this._nValue - Math.floor(this._nValue / 100) * 100 > _loc3 * (100 / dofus.graphics.gapi.controls.StarsDisplayer.STARS_COUNT) ? (1) : (0));
            _loc2[_loc3] = dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS[Math.min(_loc4, dofus.graphics.gapi.controls.StarsDisplayer.STARS_COLORS.length - 1)];
        } // end while
        return (_loc2);
    };
    _loc1.addProperty("value", _loc1.__get__value, _loc1.__set__value);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.StarsDisplayer = function ()
    {
        super();
    }).CLASS_NAME = "StarsDisplayer";
    (_global.dofus.graphics.gapi.controls.StarsDisplayer = function ()
    {
        super();
    }).STARS_COUNT = 5;
    (_global.dofus.graphics.gapi.controls.StarsDisplayer = function ()
    {
        super();
    }).STARS_COLORS = [-1, 16777011, 16750848, 39168, 39372, 6697728, 2236962, 16711680, 65280, 16777215, 16711935];
} // end if
#endinitclip
