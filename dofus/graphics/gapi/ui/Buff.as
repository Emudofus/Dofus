// Action script...

// [Initial MovieClip Action of sprite 20787]
#initclip 52
if (!dofus.graphics.gapi.ui.Buff)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.Buff = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Buff.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        var _loc2 = 20;
        
        while (++_loc2, _loc2 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.addEventListener("click", this);
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
        } // end while
        this.api.datacenter.Player.Inventory.addEventListener("modelChanged", this);
    };
    _loc1.updateData = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 20;
        
        while (++_loc3, _loc3 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
        {
            _loc2[_loc3] = true;
        } // end while
        var _loc4 = this.api.datacenter.Player.Inventory;
        for (var k in _loc4)
        {
            var _loc5 = _loc4[k];
            if (!_global.isNaN(_loc5.position))
            {
                var _loc6 = _loc5.position;
                if (_loc6 < 20 || _loc6 > dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
                {
                    continue;
                } // end if
                var _loc7 = this["_ctr" + _loc6];
                _loc7.contentData = _loc5;
                _loc7.enabled = true;
                _loc2[_loc6] = false;
            } // end if
        } // end of for...in
        var _loc8 = 20;
        
        while (++_loc8, _loc8 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
        {
            if (_loc2[_loc8])
            {
                var _loc9 = this["_ctr" + _loc8];
                _loc9.contentData = undefined;
                _loc9.enabled = false;
            } // end if
        } // end while
    };
    _loc1.modelChanged = function (oEvent)
    {
        switch (oEvent.eventName)
        {
            case "updateOne":
            case "updateAll":
        } // End of switch
        this.updateData();
        
    };
    _loc1.click = function (oEvent)
    {
        this.gapi.loadUIComponent("BuffInfos", "BuffInfos", {data: oEvent.target.contentData}, {bStayIfPresent: true});
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 != undefined)
        {
            this.gapi.showTooltip(_loc3.name + "\n" + _loc3.visibleEffects, oEvent.target, 30);
        } // end if
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Buff = function ()
    {
        super();
    }).CLASS_NAME = "Buff";
    (_global.dofus.graphics.gapi.ui.Buff = function ()
    {
        super();
    }).LAST_CONTAINER = 27;
} // end if
#endinitclip
