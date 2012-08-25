// Action script...

// [Initial MovieClip Action of sprite 20748]
#initclip 13
if (!dofus.aks.Key)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Key = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.leave = function ()
    {
        this.aks.send("KV", false);
    };
    _loc1.sendKey = function (nType, sKeyCode)
    {
        this.aks.send("KK" + nType + "|" + sKeyCode);
    };
    _loc1.onCreate = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        this.api.ui.loadUIComponent("KeyCode", "KeyCode", {title: this.api.lang.getText("TYPE_CODE"), changeType: _loc4, slotsCount: _loc5});
    };
    _loc1.onKey = function (bSuccess)
    {
        var _loc3 = bSuccess ? (this.api.lang.getText("CODE_CHANGED")) : (this.api.lang.getText("BAD_CODE"));
        this.api.kernel.showMessage(this.api.lang.getText("CODE"), _loc3, "ERROR_BOX", {name: "Key"});
    };
    _loc1.onLeave = function ()
    {
        this.api.ui.unloadUIComponent("KeyCode");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
