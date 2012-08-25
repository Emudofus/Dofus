// Action script...

// [Initial MovieClip Action of sprite 20497]
#initclip 18
if (!dofus.datacenter.Quest)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Quest = function (nID, bFinished, nSortOrder)
    {
        super();
        this.initialize(nID, bFinished, nSortOrder);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__isFinished = function ()
    {
        return (this._bFinished);
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getQuestText(this._nID));
    };
    _loc1.__get__currentStep = function ()
    {
        return (this._oCurrentStep);
    };
    _loc1.addStep = function (oStep)
    {
        this._eoSteps.addItemAt(oStep.id, oStep);
        if (oStep.isCurrent)
        {
            this._oCurrentStep = oStep;
        } // end if
    };
    _loc1.initialize = function (nID, bFinished, nSortOrder)
    {
        this.api = _global.API;
        this._eoSteps = new ank.utils.ExtendedObject();
        this._nID = nID;
        this._bFinished = bFinished;
        this.sortOrder = nSortOrder;
    };
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("currentStep", _loc1.__get__currentStep, function ()
    {
    });
    _loc1.addProperty("isFinished", _loc1.__get__isFinished, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
