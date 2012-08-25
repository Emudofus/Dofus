// Action script...

// [Initial MovieClip Action of sprite 20546]
#initclip 67
if (!dofus.datacenter.Question)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Question = function (nQuestionID, aResponsesID, aQuestionParams)
    {
        super();
        this.initialize(nQuestionID, aResponsesID, aQuestionParams);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nQuestionID);
    };
    _loc1.__get__label = function ()
    {
        return (this.api.lang.fetchString(this._sQuestionText));
    };
    _loc1.__get__responses = function ()
    {
        return (this._eaResponsesObjects);
    };
    _loc1.initialize = function (nQuestionID, aResponsesID, aQuestionParams)
    {
        this.api = _global.API;
        this._nQuestionID = nQuestionID;
        this._sQuestionText = ank.utils.PatternDecoder.getDescription(this.api.lang.getDialogQuestionText(nQuestionID), aQuestionParams);
        this._eaResponsesObjects = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < aResponsesID.length)
        {
            var _loc6 = Number(aResponsesID[_loc5]);
            this._eaResponsesObjects.push({label: this.api.lang.fetchString(this.api.lang.getDialogResponseText(_loc6)), id: _loc6});
        } // end while
    };
    _loc1.addProperty("label", _loc1.__get__label, function ()
    {
    });
    _loc1.addProperty("responses", _loc1.__get__responses, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
