// Action script...

// [Initial MovieClip Action of sprite 20928]
#initclip 193
if (!dofus.datacenter.QuestStep)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.QuestStep = function (nID, nState, eaObjectives, aPreviousSteps, aNextSteps, nDialogID, aDialogParams)
    {
        super();
        this.initialize(nID, nState, eaObjectives, aPreviousSteps, aNextSteps, nDialogID, aDialogParams);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__name = function ()
    {
        return (this.api.lang.getQuestStepText(this._nID).n);
    };
    _loc1.__get__description = function ()
    {
        return (this.api.lang.getQuestStepText(this._nID).d);
    };
    _loc1.__get__objectives = function ()
    {
        return (this._eaObjectives);
    };
    _loc1.__get__allSteps = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aPreviousSteps.length)
        {
            _loc2.push(new dofus.datacenter.QuestStep(this._aPreviousSteps[_loc3], 2));
        } // end while
        _loc2.push(this);
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aNextSteps.length)
        {
            _loc2.push(new dofus.datacenter.QuestStep(this._aNextSteps[_loc4], 0));
        } // end while
        return (_loc2);
    };
    _loc1.__get__rewards = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = this.api.lang.getQuestStepText(this._nID).r;
        if (_loc3[0] != undefined)
        {
            _loc2.push({iconFile: "UI_QuestXP", label: _loc3[0]});
        } // end if
        if (_loc3[1] != undefined)
        {
            _loc2.push({iconFile: "UI_QuestKamaSymbol", label: _loc3[1]});
        } // end if
        if (_loc3[2] != undefined)
        {
            var _loc4 = _loc3[2];
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc4.length)
            {
                var _loc6 = Number(_loc4[_loc5][0]);
                var _loc7 = _loc4[_loc5][1];
                var _loc8 = new dofus.datacenter.Item(0, _loc6, _loc7);
                _loc2.push({iconFile: _loc8.iconFile, label: (_loc7 != 0 ? ("x" + _loc7 + " ") : ("")) + _loc8.name});
            } // end while
        } // end if
        if (_loc3[3] != undefined)
        {
            var _loc9 = _loc3[3];
            var _loc10 = 0;
            
            while (++_loc10, _loc10 < _loc9.length)
            {
                var _loc11 = Number(_loc9[_loc10]);
                _loc2.push({iconFile: dofus.Constants.EMOTES_ICONS_PATH + _loc11 + ".swf", label: this.api.lang.getEmoteText(_loc11).n});
            } // end while
        } // end if
        if (_loc3[4] != undefined)
        {
            var _loc12 = _loc3[4];
            var _loc13 = 0;
            
            while (++_loc13, _loc13 < _loc12.length)
            {
                var _loc14 = Number(_loc12[_loc13]);
                var _loc15 = new dofus.datacenter.Job(_loc14);
                _loc2.push({iconFile: _loc15.iconFile, label: _loc15.name});
            } // end while
        } // end if
        if (_loc3[5] != undefined)
        {
            var _loc16 = _loc3[5];
            var _loc17 = 0;
            
            while (++_loc17, _loc17 < _loc16.length)
            {
                var _loc18 = Number(_loc16[_loc17]);
                var _loc19 = new dofus.datacenter.Spell(_loc18, 1);
                _loc2.push({iconFile: _loc19.iconFile, label: _loc19.name});
            } // end while
        } // end if
        return (_loc2);
    };
    _loc1.__get__dialogID = function ()
    {
        return (this._nDialogID);
    };
    _loc1.__get__dialogParams = function ()
    {
        return (this._aDialogParams);
    };
    _loc1.__get__isFinished = function ()
    {
        return (this._nState == 2);
    };
    _loc1.__get__isCurrent = function ()
    {
        return (this._nState == 1);
    };
    _loc1.__get__isNotDo = function ()
    {
        return (this._nState == 0);
    };
    _loc1.__get__hasPrevious = function ()
    {
        return (true);
    };
    _loc1.__get__hasNext = function ()
    {
        return (true);
    };
    _loc1.initialize = function (nID, nState, eaObjectives, aPreviousSteps, aNextSteps, nDialogID, aDialogParams)
    {
        this.api = _global.API;
        this._nID = nID;
        this._nState = nState;
        this._eaObjectives = eaObjectives;
        this._aPreviousSteps = aPreviousSteps;
        this._aNextSteps = aNextSteps;
        this._nDialogID = nDialogID;
        this._aDialogParams = aDialogParams;
    };
    _loc1.addProperty("hasNext", _loc1.__get__hasNext, function ()
    {
    });
    _loc1.addProperty("isFinished", _loc1.__get__isFinished, function ()
    {
    });
    _loc1.addProperty("objectives", _loc1.__get__objectives, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("isNotDo", _loc1.__get__isNotDo, function ()
    {
    });
    _loc1.addProperty("allSteps", _loc1.__get__allSteps, function ()
    {
    });
    _loc1.addProperty("hasPrevious", _loc1.__get__hasPrevious, function ()
    {
    });
    _loc1.addProperty("isCurrent", _loc1.__get__isCurrent, function ()
    {
    });
    _loc1.addProperty("rewards", _loc1.__get__rewards, function ()
    {
    });
    _loc1.addProperty("dialogID", _loc1.__get__dialogID, function ()
    {
    });
    _loc1.addProperty("dialogParams", _loc1.__get__dialogParams, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
