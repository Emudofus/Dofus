// Action script...

// [Initial MovieClip Action of sprite 20631]
#initclip 152
if (!dofus.graphics.gapi.ui.CrafterList)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.CrafterList = function ()
    {
        super();
    }).prototype;
    _loc1.__set__jobs = function (eaJobs)
    {
        this._eaJobs = eaJobs;
        if (this.initialized)
        {
            this.updateJobs();
        } // end if
        //return (this.jobs());
    };
    _loc1.__set__crafters = function (eaCrafters)
    {
        this._eaCrafters.removeEventListener("modelChanged", this);
        this._eaCrafters = eaCrafters;
        this._eaCrafters.addEventListener("modelChanged", this);
        if (this.initialized)
        {
            this.updateCrafters();
        } // end if
        //return (this.crafters());
    };
    _loc1.__get__crafters = function ()
    {
        return (this._eaCrafters);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.CrafterList.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        ank.utils.Timer.removeTimer(this, "simulation");
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._dgCrafter.addEventListener("itemSelected", this);
        this._dgCrafter.addEventListener("itemdblClick", this);
        this._cbJobs.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblJob.text = this.api.lang.getText("JOB");
        this._winBackground.title = this.api.lang.getText("CRAFTERS_LIST");
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._dgCrafter.columnsNames = ["", this.api.lang.getText("NAME_BIG"), this.api.lang.getText("LEVEL_SMALL"), this.api.lang.getText("SUBAREA"), this.api.lang.getText("COORDINATES"), this.api.lang.getText("IN_WORKSHOP"), this.api.lang.getText("NOT_FREE"), this.api.lang.getText("MIN_ITEM_IN_RECEIPT")];
    };
    _loc1.updateData = function ()
    {
        this.updateJobs();
    };
    _loc1.updateJobs = function ()
    {
        this._cbJobs.dataProvider = this._eaJobs;
    };
    _loc1.updateCrafters = function ()
    {
        this._dgCrafter.dataProvider = this._eaCrafters;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            case this._btnClose2:
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.itemdblClick = function (oEvent)
    {
        this.itemSelected(oEvent);
    };
    _loc1.itemSelected = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._cbJobs:
            {
                this._eaCrafters.removeAll();
                this.api.network.Exchange.getCrafterForJob(this._cbJobs.selectedItem.id);
                break;
            } 
            case this._dgCrafter:
            {
                var _loc3 = oEvent.row.item;
                this.api.ui.loadUIComponent("CrafterCard", "CrafterCard", {crafter: _loc3});
                break;
            } 
        } // End of switch
    };
    _loc1.modelChanged = function (oEvent)
    {
        this.updateCrafters();
    };
    _loc1.addProperty("crafters", _loc1.__get__crafters, _loc1.__set__crafters);
    _loc1.addProperty("jobs", function ()
    {
    }, _loc1.__set__jobs);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.CrafterList = function ()
    {
        super();
    }).CLASS_NAME = "CrafterList";
} // end if
#endinitclip
