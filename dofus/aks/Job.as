// Action script...

// [Initial MovieClip Action of sprite 20580]
#initclip 101
if (!dofus.aks.Job)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Job = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.changeJobStats = function (nJobID, params, minSlots)
    {
        this.aks.send("JO" + nJobID + "|" + params + "|" + minSlots);
    };
    _loc1.onSkills = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = this.api.datacenter.Player.Jobs;
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            var _loc6 = _loc3[_loc5].split(";");
            var _loc7 = Number(_loc6[0]);
            var _loc8 = new ank.utils.ExtendedArray();
            var _loc9 = _loc6[1].split(",");
            var _loc10 = _loc9.length;
            while (_loc10-- > 0)
            {
                var _loc11 = _loc9[_loc10].split("~");
                _loc8.push(new dofus.datacenter.Skill(_loc11[0], _loc11[1], _loc11[2], _loc11[3], _loc11[4]));
            } // end while
            var _loc12 = new dofus.datacenter.Job(_loc7, _loc8);
            var _loc13 = _loc4.findFirstItem("id", _loc7);
            if (_loc13.index != -1)
            {
                _loc4.updateItem(_loc13.index, _loc12);
                continue;
            } // end if
            _loc4.push(_loc12);
        } // end while
    };
    _loc1.onXP = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = this.api.datacenter.Player.Jobs;
        var _loc5 = _loc3.length;
        while (_loc5-- > 0)
        {
            var _loc6 = _loc3[_loc5].split(";");
            var _loc7 = Number(_loc6[0]);
            var _loc8 = Number(_loc6[1]);
            var _loc9 = Number(_loc6[2]);
            var _loc10 = Number(_loc6[3]);
            var _loc11 = Number(_loc6[4]);
            var _loc12 = _loc4.findFirstItem("id", _loc7);
            if (_loc12.index != -1)
            {
                var _loc13 = _loc12.item;
                _loc13.level = _loc8;
                _loc13.xpMin = _loc9;
                _loc13.xp = _loc10;
                _loc13.xpMax = _loc11;
                _loc4.updateItem(_loc12.index, _loc13);
            } // end if
        } // end while
    };
    _loc1.onLevel = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"), this.api.lang.getText("NEW_JOB_LEVEL", [this.api.lang.getJobText(_loc4).n, _loc5]), "ERROR_BOX", {name: "NewJobLevel"});
    };
    _loc1.onRemove = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        var _loc4 = this.api.datacenter.Player.Jobs;
        var _loc5 = _loc4.findFirstItem("id", _loc3);
        if (_loc5.index != -1)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("REMOVE_JOB", [_loc5.item.name]), "INFO_CHAT");
            _loc4.removeItems(_loc5.index, 1);
        } // end if
    };
    _loc1.onOptions = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]);
        this.api.datacenter.Player.Jobs[_loc4].options = new dofus.datacenter.JobOptions(_loc5, _loc6);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
