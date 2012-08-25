// Action script...

// [Initial MovieClip Action of sprite 20693]
#initclip 214
if (!dofus.aks.Fights)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Fights = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.getList = function ()
    {
        this.aks.send("fL");
    };
    _loc1.getDetails = function (nID)
    {
        this.aks.send("fD" + nID, false);
    };
    _loc1.blockSpectators = function ()
    {
        this.aks.send("fS");
    };
    _loc1.blockJoinerExceptParty = function ()
    {
        this.aks.send("fP");
    };
    _loc1.blockJoiner = function ()
    {
        this.aks.send("fN");
    };
    _loc1.needHelp = function ()
    {
        this.aks.send("fH");
    };
    _loc1.onCount = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        if (_global.isNaN(_loc3) || (sExtraData.length == 0 || _loc3 == 0))
        {
            this.api.ui.getUIComponent("Banner").fightsCount = 0;
        }
        else
        {
            this.api.ui.getUIComponent("Banner").fightsCount = _loc3;
        } // end else if
    };
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = new Array();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            if (String(_loc3[_loc5]).length == 0)
            {
                continue;
            } // end if
            var _loc6 = _loc3[_loc5].split(";");
            var _loc7 = Number(_loc6[0]);
            var _loc8 = Number(_loc6[1]);
            var _loc9 = _loc8 == -1 ? (-1) : (this.api.kernel.NightManager.getDiffDate(_loc8));
            var _loc10 = new dofus.datacenter.FightInfos(_loc7, _loc9);
            var _loc11 = String(_loc6[2]).split(",");
            var _loc12 = Number(_loc11[0]);
            var _loc13 = Number(_loc11[1]);
            var _loc14 = Number(_loc11[2]);
            _loc10.addTeam(1, _loc12, _loc13, _loc14);
            var _loc15 = String(_loc6[3]).split(",");
            var _loc16 = Number(_loc15[0]);
            var _loc17 = Number(_loc15[1]);
            var _loc18 = Number(_loc15[2]);
            _loc10.addTeam(2, _loc16, _loc17, _loc18);
            _loc4.push(_loc10);
        } // end while
        this.api.ui.getUIComponent("FightsInfos").fights.replaceAll(0, _loc4);
    };
    _loc1.onDetails = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = _loc3[1].split(";");
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc6.length)
        {
            if (_loc6[_loc7] == "")
            {
                continue;
            } // end if
            var _loc8 = _loc6[_loc7].split("~");
            _loc5.push({name: this.api.kernel.CharactersManager.getNameFromData(_loc8[0]).name, level: Number(_loc8[1]), type: this.api.kernel.CharactersManager.getNameFromData(_loc8[0]).type});
        } // end while
        var _loc9 = new ank.utils.ExtendedArray();
        var _loc10 = _loc3[2].split(";");
        var _loc11 = 0;
        
        while (++_loc11, _loc11 < _loc10.length)
        {
            if (_loc10[_loc11] == "")
            {
                continue;
            } // end if
            var _loc12 = _loc10[_loc11].split("~");
            _loc9.push({name: this.api.kernel.CharactersManager.getNameFromData(_loc12[0]).name, level: Number(_loc12[1]), type: this.api.kernel.CharactersManager.getNameFromData(_loc12[0]).type});
        } // end while
        this.api.ui.getUIComponent("FightsInfos").addFightTeams(_loc4, _loc5, _loc9);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
