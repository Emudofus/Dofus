// Action script...

// [Initial MovieClip Action of sprite 20810]
#initclip 75
if (!dofus.managers.NightManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.NightManager = function (oApi)
    {
        dofus.managers.NightManager._sSelf = this;
        this._oApi = oApi;
    }).prototype;
    _loc1.__get__time = function ()
    {
        var _loc2 = this.getCurrentTime();
        if (new ank.utils.ExtendedString(_loc2[1]).addLeftChar("0", 2) == "undefined")
        {
            return ("");
        } // end if
        return (new ank.utils.ExtendedString(_loc2[0]).addLeftChar("0", 2) + ":" + new ank.utils.ExtendedString(_loc2[1]).addLeftChar("0", 2));
    };
    _loc1.__get__date = function ()
    {
        return (this.getCurrentDateString());
    };
    _loc1.initialize = function (tz, aMonths, nYearOffset, b)
    {
        this._aSequence = tz;
        this._aMonths = aMonths;
        this._nYearOffset = nYearOffset;
        this._mcBattlefield = b;
    };
    _loc1.setReferenceTime = function (nTine)
    {
        this._cdDate = new ank.utils.CustomDate(nTine, this._aMonths, this._nYearOffset);
        this.clear();
        this.setState();
    };
    _loc1.setReferenceDate = function (nYear, nMonth, nDay)
    {
        this._nYear = nYear;
        this._nMonth = nMonth;
        this._nDay = nDay;
    };
    _loc1.clear = function ()
    {
        _global.clearInterval(this._nIntervalID);
    };
    _loc1.noEffects = function ()
    {
        this.clear();
        this._mcBattlefield.setColor();
    };
    _loc1.getCurrentTime = function ()
    {
        return (this._cdDate.getCurrentTime());
    };
    _loc1.getCurrentDateString = function ()
    {
        var _loc2 = this._cdDate.getCurrentDate();
        if (getTimer() - this._oApi.datacenter.Basics.lastDateUpdate > 60000)
        {
            this._oApi.network.Basics.getDate();
        } // end if
        var _loc3 = this._nYear != undefined ? (this._nDay + " " + this._aMonths[11 - this._nMonth][1] + " " + this._nYear) : (_loc2[2] + " " + _loc2[1] + " " + _loc2[0]);
        return (_loc3);
    };
    _loc1.getDiffDate = function (nTime)
    {
        return (this._cdDate.getDiffDate(nTime));
    };
    (_global.dofus.managers.NightManager = function (oApi)
    {
        dofus.managers.NightManager._sSelf = this;
        this._oApi = oApi;
    }).getInstance = function ()
    {
        return (dofus.managers.NightManager._sSelf);
    };
    _loc1.setState = function ()
    {
        var _loc2 = this._cdDate.getCurrentMillisInDay();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aSequence.length)
        {
            var _loc4 = this._aSequence[_loc3][1];
            if (_loc2 < _loc4)
            {
                var _loc5 = this._aSequence[_loc3][2];
                this.applyState(_loc5, _loc4 - _loc2, _loc4);
                return;
            } // end if
        } // end while
        ank.utils.Logger.err("[setState] ... heu la date " + _loc2 + " n\'est pas dans la séquence");
    };
    _loc1.applyState = function (oStateColor, nDelay, nEndTime)
    {
        this._mcBattlefield.setColor(oStateColor);
        this.clear();
        this._nIntervalID = _global.setInterval(this, "setState", nDelay, nEndTime);
    };
    _loc1.addProperty("date", _loc1.__get__date, function ()
    {
    });
    _loc1.addProperty("time", _loc1.__get__time, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.NightManager = function (oApi)
    {
        dofus.managers.NightManager._sSelf = this;
        this._oApi = oApi;
    }).STATE_COLORS = [undefined, dofus.Constants.NIGHT_COLOR];
    (_global.dofus.managers.NightManager = function (oApi)
    {
        dofus.managers.NightManager._sSelf = this;
        this._oApi = oApi;
    })._sSelf = null;
} // end if
#endinitclip
