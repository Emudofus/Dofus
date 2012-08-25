// Action script...

// [Initial MovieClip Action of sprite 20595]
#initclip 116
if (!dofus.aks.Quests)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Quests = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.getList = function ()
    {
        this.aks.send("QL");
    };
    _loc1.getStep = function (nQuestID, nDelta)
    {
        this.aks.send("QS" + nQuestID + (nDelta != undefined ? ("|" + (nDelta > 0 ? ("+" + nDelta) : (nDelta))) : ("")));
    };
    _loc1.onList = function (sExtraData)
    {
        var _loc3 = 0;
        var _loc4 = new Array();
        if (sExtraData.length != 0)
        {
            var _loc5 = sExtraData.split("|");
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5.length)
            {
                var _loc7 = _loc5[_loc6].split(";");
                var _loc8 = Number(_loc7[0]);
                var _loc9 = _loc7[1] == "1";
                var _loc10 = Number(_loc7[2]);
                if (!_loc9)
                {
                    ++_loc3;
                } // end if
                var _loc11 = new dofus.datacenter.Quest(_loc8, _loc9, _loc10);
                _loc4.push(_loc11);
            } // end while
        } // end if
        this.api.datacenter.Temporary.QuestBook.quests.replaceAll(0, _loc4);
        this.api.ui.getUIComponent("Quests").setPendingCount(_loc3);
    };
    _loc1.onStep = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = _loc3[2];
        var _loc7 = new ank.utils.ExtendedArray();
        var _loc8 = _loc3[3];
        var _loc9 = _loc8.length == 0 ? (new Array()) : (_loc8.split(";"));
        _loc9.reverse();
        var _loc10 = _loc3[4];
        var _loc11 = _loc10.length == 0 ? (new Array()) : (_loc10.split(";"));
        var _loc12 = _loc3[5].split(";");
        var _loc13 = _loc12[0];
        var _loc14 = _loc12[1].split(",");
        var _loc15 = _loc6.split(";");
        var _loc16 = 0;
        
        while (++_loc16, _loc16 < _loc15.length)
        {
            var _loc17 = _loc15[_loc16].split(",");
            var _loc18 = Number(_loc17[0]);
            var _loc19 = _loc17[1] == "1";
            var _loc20 = new dofus.datacenter.QuestObjective(_loc18, _loc19);
            _loc7.push(_loc20);
        } // end while
        var _loc21 = this.api.datacenter.Temporary.QuestBook;
        var _loc22 = _loc21.getQuest(_loc4);
        if (_loc22 != null)
        {
            var _loc23 = new dofus.datacenter.QuestStep(_loc5, 1, _loc7, _loc9, _loc11, _loc13, _loc14);
            _loc22.addStep(_loc23);
            this.api.ui.getUIComponent("Quests").setStep(_loc23);
        }
        else
        {
            ank.utils.Logger.err("[onStep] Impossible de trouver l\'objet de quête");
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
