// Action script...

// [Initial MovieClip Action of sprite 20685]
#initclip 206
if (!dofus.managers.DebugManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.DebugManager = function (oAPI)
    {
        super();
        dofus.managers.DebugManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.DebugManager = function (oAPI)
    {
        super();
        dofus.managers.DebugManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.DebugManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this.setDebug(dofus.Constants.DEBUG == true);
    };
    _loc1.setDebug = function (bOnOff)
    {
        this._bDebugEnabled = bOnOff;
        this.print("Debug mode " + (bOnOff ? ("ON") : ("OFF")), 5, true);
    };
    _loc1.toggleDebug = function ()
    {
        this.setDebug(!this._bDebugEnabled);
    };
    _loc1.print = function (sMsg, nLevel, bEvenIfOff)
    {
        if (!bEvenIfOff && !this._bDebugEnabled)
        {
            return;
        } // end if
        var _loc5 = this.getTimestamp() + " ";
        _loc5 = _loc5 + sMsg;
        var _loc6 = "DEBUG_INFO";
        switch (nLevel)
        {
            case 5:
            {
                _loc6 = "ERROR_CHAT";
                break;
            } 
            case 4:
            {
                _loc6 = "MESSAGE_CHAT";
                break;
            } 
            case 3:
            {
                _loc6 = "DEBUG_ERROR";
                break;
            } 
            case 2:
            {
                _loc6 = "DEBUG_LOG";
                break;
            } 
            default:
            {
                _loc6 = "DEBUG_INFO";
                break;
            } 
        } // End of switch
        this.api.kernel.showMessage(undefined, _loc5, _loc6);
    };
    _loc1.getTimestamp = function ()
    {
        var _loc2 = new Date();
        return ("[" + new ank.utils.ExtendedString(_loc2.getHours()).addLeftChar("0", 2) + ":" + new ank.utils.ExtendedString(_loc2.getMinutes()).addLeftChar("0", 2) + ":" + new ank.utils.ExtendedString(_loc2.getSeconds()).addLeftChar("0", 2) + ":" + new ank.utils.ExtendedString(_loc2.getMilliseconds()).addLeftChar("0", 3) + "]");
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.DebugManager = function (oAPI)
    {
        super();
        dofus.managers.DebugManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
} // end if
#endinitclip
