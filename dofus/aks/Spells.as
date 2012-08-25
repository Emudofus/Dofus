// Action script...

// [Initial MovieClip Action of sprite 20921]
#initclip 186
if (!dofus.aks.Spells)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Spells = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.moveToUsed = function (nID, nPosition)
    {
        this.aks.send("SM" + nID + "|" + nPosition, false);
    };
    _loc1.boost = function (nID)
    {
        this.aks.send("SB" + nID);
    };
    _loc1.spellForget = function (nID)
    {
        this.aks.send("SF" + nID);
    };
    _loc1.onUpgradeSpell = function (bSuccess, sExtraData)
    {
        if (bSuccess)
        {
            var _loc4 = this.api.kernel.CharactersManager.getSpellObjectFromData(sExtraData);
            this.api.datacenter.Player.updateSpell(_loc4);
        }
        else
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("CANT_BOOST_SPELL"), "ERROR_BOX");
        } // end else if
    };
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = this.api.datacenter.Player;
        _loc4.Spells.removeItems(1, _loc4.Spells.length);
        var _loc5 = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc3.length)
        {
            var _loc7 = _loc3[_loc6];
            if (_loc7.length != 0)
            {
                var _loc8 = this.api.kernel.CharactersManager.getSpellObjectFromData(_loc7);
                if (_loc8 != undefined)
                {
                    _loc5.push(_loc8);
                } // end if
            } // end if
        } // end while
        _loc4.Spells.replaceAll(1, _loc5);
    };
    _loc1.onChangeOption = function (sExtraData)
    {
        this.api.datacenter.Basics.canUseSeeAllSpell = sExtraData.charAt(0) == "+";
    };
    _loc1.onSpellBoost = function (sExtraData)
    {
        var _loc3 = sExtraData.split(";");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = Number(_loc3[2]);
        this.api.kernel.SpellsBoostsManager.setSpellModificator(_loc4, _loc5, _loc6);
    };
    _loc1.onSpellForget = function (sExtraData)
    {
        if (sExtraData == "+")
        {
            this.api.ui.loadUIComponent("SpellForget", "SpellForget", undefined, {bStayIfPresent: true});
        }
        else if (sExtraData == "-")
        {
            this.api.ui.unloadUIComponent("SpellForget");
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
