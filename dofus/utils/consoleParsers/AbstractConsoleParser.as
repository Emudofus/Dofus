// Action script...

// [Initial MovieClip Action of sprite 20936]
#initclip 201
if (!dofus.utils.consoleParsers.AbstractConsoleParser)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.consoleParsers)
    {
        _global.dofus.utils.consoleParsers = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.consoleParsers.AbstractConsoleParser = function ()
    {
    }).prototype;
    _loc1.__get__api = function ()
    {
        return (this._oAPI);
    };
    _loc1.__set__api = function (oApi)
    {
        this._oAPI = oApi;
        //return (this.api());
    };
    _loc1.initialize = function (oAPI)
    {
        this._oAPI = oAPI;
        this._aConsoleHistory = new Array();
        this._nConsoleHistoryPointer = 0;
    };
    _loc1.process = function (sCmd, oParams)
    {
        this.pushHistory({value: sCmd, params: oParams});
    };
    _loc1.pushHistory = function (oCommand)
    {
        var _loc3 = this._aConsoleHistory.slice(-1);
        if (_loc3[0].value != oCommand.value)
        {
            var _loc4 = this._aConsoleHistory.push(oCommand);
            if (_loc4 > 50)
            {
                this._aConsoleHistory.shift();
            } // end if
        } // end if
        this.initializePointers();
    };
    _loc1.getHistoryUp = function ()
    {
        if (this._nConsoleHistoryPointer > 0)
        {
            --this._nConsoleHistoryPointer;
        } // end if
        var _loc2 = this._aConsoleHistory[this._nConsoleHistoryPointer];
        return (_loc2);
    };
    _loc1.getHistoryDown = function ()
    {
        if (this._nConsoleHistoryPointer < this._aConsoleHistory.length)
        {
            ++this._nConsoleHistoryPointer;
        } // end if
        var _loc2 = this._aConsoleHistory[this._nConsoleHistoryPointer];
        return (_loc2);
    };
    _loc1.autoCompletion = function (aList, sCmd)
    {
        return (ank.utils.ConsoleUtils.autoCompletion(aList, sCmd));
    };
    _loc1.initializePointers = function ()
    {
        this._nConsoleHistoryPointer = this._aConsoleHistory.length;
    };
    _loc1.addProperty("api", _loc1.__get__api, _loc1.__set__api);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
