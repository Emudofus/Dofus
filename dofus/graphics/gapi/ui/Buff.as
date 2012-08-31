// Action script...

// [Initial MovieClip Action of sprite 1047]
#initclip 14
class dofus.graphics.gapi.ui.Buff extends ank.gapi.core.UIAdvancedComponent
{
    var addToQueue, api, gapi;
    function Buff()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Buff.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: updateData});
    } // End of the function
    function addListeners()
    {
        for (var _loc3 = 20; _loc3 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER; ++_loc3)
        {
            var _loc2 = this["_ctr" + _loc3];
            _loc2.addEventListener("click", this);
            _loc2.addEventListener("over", this);
            _loc2.addEventListener("out", this);
        } // end of for
        api.datacenter.Player.Inventory.addEventListener("modelChanged", this);
    } // End of the function
    function updateData()
    {
        var _loc6 = new Array();
        for (var _loc3 = 20; _loc3 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER; ++_loc3)
        {
            _loc6[_loc3] = true;
        } // end of for
        var _loc7 = api.datacenter.Player.Inventory;
        for (var _loc8 in _loc7)
        {
            var _loc4 = _loc7[_loc8];
            if (!isNaN(_loc4.position))
            {
                var _loc2 = _loc4.position;
                if (_loc2 < 20 || _loc2 > dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
                {
                    continue;
                } // end if
                var _loc5 = this["_ctr" + _loc2];
                _loc5.contentData = _loc4;
                _loc5.enabled = true;
                _loc6[_loc2] = false;
            } // end if
        } // end of for...in
        for (var _loc3 = 20; _loc3 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER; ++_loc3)
        {
            if (_loc6[_loc3])
            {
                _loc5 = this["_ctr" + _loc3];
                _loc5.contentData = undefined;
                _loc5.enabled = false;
            } // end if
        } // end of for
    } // End of the function
    function modelChanged(oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        this.updateData();
        
    } // End of the function
    function click(oEvent)
    {
        gapi.loadUIComponent("BuffInfos", "BuffInfos", {data: oEvent.target.contentData}, {bStayIfPresent: true});
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        if (_loc2 != undefined)
        {
            gapi.showTooltip(_loc2.name + "\n" + _loc2.visibleEffects, oEvent.target, 30);
        } // end if
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "Buff";
    static var LAST_CONTAINER = 27;
} // End of Class
#endinitclip
