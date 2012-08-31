// Action script...

// [Initial MovieClip Action of sprite 896]
#initclip 108
class dofus.datacenter.TutorialIf extends dofus.datacenter.TutorialBloc
{
    var _mLeft, _sOperator, _mRight, _mNextBlocTrueID, _mNextBlocFalseID, __get__left, __get__nextBlocFalseID, __get__nextBlocTrueID, __get__operator, __get__right;
    function TutorialIf(sID, mLeft, sOperator, mRight, mNextBlocTrueID, mNextBlocFalseID)
    {
        super(sID, dofus.datacenter.TutorialBloc.TYPE_IF);
        _mLeft = mLeft;
        _sOperator = sOperator;
        _mRight = mRight;
        _mNextBlocTrueID = mNextBlocTrueID;
        _mNextBlocFalseID = mNextBlocFalseID;
    } // End of the function
    function get left()
    {
        return (_mLeft);
    } // End of the function
    function get operator()
    {
        return (_sOperator);
    } // End of the function
    function get right()
    {
        return (_mRight);
    } // End of the function
    function get nextBlocTrueID()
    {
        return (_mNextBlocTrueID);
    } // End of the function
    function get nextBlocFalseID()
    {
        return (_mNextBlocFalseID);
    } // End of the function
} // End of Class
#endinitclip
