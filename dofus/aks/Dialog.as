// Action script...

// [Initial MovieClip Action of sprite 20513]
#initclip 34
if (!dofus.aks.Dialog)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Dialog = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.begining = function (sNpcID)
    {
        this.aks.send("DB" + sNpcID, true);
    };
    _loc1.create = function (sNpcID)
    {
        this.aks.send("DC" + sNpcID, true);
    };
    _loc1.leave = function ()
    {
        this.aks.send("DV", true);
    };
    _loc1.response = function (nQuestionID, nResponseID)
    {
        this.aks.send("DR" + nQuestionID + "|" + nResponseID, true);
    };
    _loc1.onCustomAction = function (sExtraData)
    {
        switch (sExtraData)
        {
            case "1":
            {
                getURL("javascript:DownloadOs()", "_self");
                break;
            } 
        } // End of switch
    };
    _loc1.onCreate = function (bSuccess, sExtraData)
    {
        if (!bSuccess)
        {
            return;
        } // end if
        var _loc4 = Number(sExtraData);
        var _loc5 = this.api.datacenter.Sprites.getItemAt(_loc4);
        var _loc6 = new Array();
        _loc6[1] = _loc5.color1 == undefined ? (-1) : (_loc5.color1);
        _loc6[2] = _loc5.color2 == undefined ? (-1) : (_loc5.color2);
        _loc6[3] = _loc5.color3 == undefined ? (-1) : (_loc5.color3);
        this.api.ui.loadUIComponent("NpcDialog", "NpcDialog", {name: _loc5.name, gfx: _loc5.gfxID, id: _loc4, customArtwork: _loc5.customArtwork, colors: _loc6});
    };
    _loc1.onQuestion = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0].split(";");
        var _loc5 = Number(_loc4[0]);
        var _loc6 = _loc4[1].split(",");
        var _loc7 = _loc3[1].split(";");
        var _loc8 = new dofus.datacenter.Question(_loc5, _loc7, _loc6);
        this.api.ui.getUIComponent("NpcDialog").setQuestion(_loc8);
    };
    _loc1.onPause = function ()
    {
        this.api.ui.getUIComponent("NpcDialog").setPause();
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("NpcDialog");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
