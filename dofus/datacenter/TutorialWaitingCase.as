// Action script...

// [Initial MovieClip Action of sprite 895]
#initclip 107
class dofus.datacenter.TutorialWaitingCase extends Object
{
    var _sCode, _aParams, _mNextBlocID, __get__code, __get__nextBlocID, __get__params;
    function TutorialWaitingCase(sCode, aParams, mNextBlocID)
    {
        super();
        _sCode = sCode;
        _aParams = aParams;
        _mNextBlocID = mNextBlocID;
    } // End of the function
    function get code()
    {
        return (_sCode);
    } // End of the function
    function get params()
    {
        return (_aParams);
    } // End of the function
    function get nextBlocID()
    {
        return (_mNextBlocID);
    } // End of the function
    static var CASE_TIMEOUT = "TIMEOUT";
    static var CASE_DEFAULT = "DEFAULT";
} // End of Class
#endinitclip
