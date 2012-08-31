// Action script...

// [Initial MovieClip Action of sprite 893]
#initclip 105
class dofus.datacenter.TutorialAction extends dofus.datacenter.TutorialBloc
{
    var _sActionCode, _aParams, _mNextBlocID, _bKeepLastWaitingBloc, __get__actionCode, __get__keepLastWaitingBloc, __get__nextBlocID, __get__params;
    function TutorialAction(sID, sActionCode, aParams, mNextBlocID, bKeepLastWaitingBloc)
    {
        super(sID, dofus.datacenter.TutorialBloc.TYPE_ACTION);
        _sActionCode = sActionCode;
        _aParams = aParams;
        _mNextBlocID = mNextBlocID;
        _bKeepLastWaitingBloc = bKeepLastWaitingBloc;
    } // End of the function
    function get actionCode()
    {
        return (_sActionCode);
    } // End of the function
    function get params()
    {
        return (_aParams);
    } // End of the function
    function get nextBlocID()
    {
        return (_mNextBlocID);
    } // End of the function
    function get keepLastWaitingBloc()
    {
        return (_bKeepLastWaitingBloc == true);
    } // End of the function
} // End of Class
#endinitclip
