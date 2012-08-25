// Action script...

// [Initial MovieClip Action of sprite 20995]
#initclip 4
if (!dofus.datacenter.QuestObjective)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.QuestObjective = function (nID, bFinished)
    {
        this.initialize(nID, bFinished);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__description = function ()
    {
        var _loc2 = this.api.lang.getQuestObjectiveText(this._nID);
        var _loc3 = _loc2.t;
        var _loc4 = _loc2.p;
        var _loc5 = new Array();
        var _loc6 = this.api.lang.getQuestObjectiveTypeText(_loc3);
        switch (_loc3)
        {
            case 0:
            case 4:
            {
                _loc5 = [_loc4[0]];
                break;
            } 
            case 1:
            case 9:
            case 10:
            {
                _loc5 = [this.api.lang.getNonPlayableCharactersText(_loc4[0]).n];
                break;
            } 
            case 2:
            case 3:
            {
                _loc5[0] = this.api.lang.getNonPlayableCharactersText(_loc4[0]).n;
                _loc5[1] = this.api.lang.getItemUnicText(_loc4[1]).n;
                _loc5[2] = _loc4[2];
                break;
            } 
            case 5:
            {
                _loc5[0] = this.api.lang.getMapSubAreaText(_loc4[0]).n;
                break;
            } 
            case 6:
            case 7:
            {
                _loc5[0] = this.api.lang.getMonstersText(_loc4[0]).n;
                _loc5[1] = _loc4[1];
                break;
            } 
            case 8:
            {
                _loc5[0] = this.api.lang.getItemUnicText(_loc4[0]).n;
                break;
            } 
            case 12:
            {
                _loc5[0] = this.api.lang.getNonPlayableCharactersText(_loc4[0]).n;
                _loc5[1] = this.api.lang.getMonstersText(_loc4[1]).n;
                _loc5[2] = _loc4[2];
                break;
            } 
        } // End of switch
        return (ank.utils.PatternDecoder.getDescription(_loc6, _loc5));
    };
    _loc1.__get__isFinished = function ()
    {
        return (this._bFinished);
    };
    _loc1.__get__x = function ()
    {
        return (this.api.lang.getQuestObjectiveText(this._nID).x);
    };
    _loc1.__get__y = function ()
    {
        return (this.api.lang.getQuestObjectiveText(this._nID).y);
    };
    _loc1.initialize = function (nID, bFinished)
    {
        this.api = _global.API;
        this._nID = nID;
        this._bFinished = bFinished;
    };
    _loc1.addProperty("x", _loc1.__get__x, function ()
    {
    });
    _loc1.addProperty("y", _loc1.__get__y, function ()
    {
    });
    _loc1.addProperty("isFinished", _loc1.__get__isFinished, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
