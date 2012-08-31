// Action script...

// [Initial MovieClip Action of sprite 904]
#initclip 116
class dofus.utils.AbstractConsoleParser
{
    var _oAPI, __get__api, _aConsoleHistory, _nConsoleHistoryPointer, __set__api;
    function AbstractConsoleParser()
    {
    } // End of the function
    function get api()
    {
        return (_oAPI);
    } // End of the function
    function set api(oApi)
    {
        _oAPI = oApi;
        //return (this.api());
        null;
    } // End of the function
    function initialize(oAPI)
    {
        _oAPI = oAPI;
        _aConsoleHistory = new Array();
        _nConsoleHistoryPointer = 0;
    } // End of the function
    function process(sCmd)
    {
        this.pushHistory(sCmd);
    } // End of the function
    function pushHistory(sCmd)
    {
        var _loc2 = _aConsoleHistory.slice(-1);
        if (_loc2[0] != sCmd)
        {
            var _loc3 = _aConsoleHistory.push(sCmd);
            if (_loc3 > 50)
            {
                _aConsoleHistory.shift();
            } // end if
        } // end if
        this.initializePointers();
    } // End of the function
    function getHistoryUp()
    {
        if (_nConsoleHistoryPointer > 0)
        {
            --_nConsoleHistoryPointer;
        } // end if
        var _loc2 = _aConsoleHistory[_nConsoleHistoryPointer];
        return (_loc2 != undefined ? (_loc2) : (""));
    } // End of the function
    function getHistoryDown()
    {
        if (_nConsoleHistoryPointer < _aConsoleHistory.length)
        {
            ++_nConsoleHistoryPointer;
        } // end if
        var _loc2 = _aConsoleHistory[_nConsoleHistoryPointer];
        return (_loc2 != undefined ? (_loc2) : (""));
    } // End of the function
    function autoCompletion(aList, sCmd)
    {
        return (ank.utils.ConsoleUtils.autoCompletion(aList, sCmd));
    } // End of the function
    function initializePointers()
    {
        _nConsoleHistoryPointer = _aConsoleHistory.length;
    } // End of the function
} // End of Class
#endinitclip
