// Action script...

// [Initial MovieClip Action of sprite 20945]
#initclip 210
if (!dofus.datacenter.TutorialIf)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.TutorialIf = function (sID, mLeft, sOperator, mRight, mNextBlocTrueID, mNextBlocFalseID)
    {
        super(sID, dofus.datacenter.TutorialBloc.TYPE_IF);
        this._mLeft = mLeft;
        this._sOperator = sOperator;
        this._mRight = mRight;
        this._mNextBlocTrueID = mNextBlocTrueID;
        this._mNextBlocFalseID = mNextBlocFalseID;
    }).prototype;
    _loc1.__get__left = function ()
    {
        return (this._mLeft);
    };
    _loc1.__get__operator = function ()
    {
        return (this._sOperator);
    };
    _loc1.__get__right = function ()
    {
        return (this._mRight);
    };
    _loc1.__get__nextBlocTrueID = function ()
    {
        return (this._mNextBlocTrueID);
    };
    _loc1.__get__nextBlocFalseID = function ()
    {
        return (this._mNextBlocFalseID);
    };
    _loc1.addProperty("nextBlocFalseID", _loc1.__get__nextBlocFalseID, function ()
    {
    });
    _loc1.addProperty("right", _loc1.__get__right, function ()
    {
    });
    _loc1.addProperty("nextBlocTrueID", _loc1.__get__nextBlocTrueID, function ()
    {
    });
    _loc1.addProperty("operator", _loc1.__get__operator, function ()
    {
    });
    _loc1.addProperty("left", _loc1.__get__left, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
