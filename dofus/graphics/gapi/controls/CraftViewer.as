// Action script...

// [Initial MovieClip Action of sprite 20933]
#initclip 198
if (!dofus.graphics.gapi.controls.CraftViewer)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.CraftViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__job = function (oJob)
    {
        this._oJob = oJob;
        this.addToQueue({object: this, method: this.layoutContent});
        //return (this.job());
    };
    _loc1.__set__skill = function (oSkill)
    {
        var _loc3 = new ank.utils.ExtendedArray();
        _loc3.push(oSkill);
        this.job = new dofus.datacenter.Job(-1, _loc3);
        //return (this.skill());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.CraftViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._lstCrafts._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
        this._btnSlot0.addEventListener("click", this);
        this._btnSlot1.addEventListener("click", this);
        this._btnSlot2.addEventListener("click", this);
        this._btnSlot3.addEventListener("click", this);
        this._btnSlot4.addEventListener("click", this);
        this._btnSlot5.addEventListener("click", this);
        this._btnSlot6.addEventListener("click", this);
        this._btnSlot7.addEventListener("click", this);
        this._btnSlot0.addEventListener("over", this);
        this._btnSlot1.addEventListener("over", this);
        this._btnSlot2.addEventListener("over", this);
        this._btnSlot3.addEventListener("over", this);
        this._btnSlot4.addEventListener("over", this);
        this._btnSlot5.addEventListener("over", this);
        this._btnSlot6.addEventListener("over", this);
        this._btnSlot7.addEventListener("over", this);
        this._btnSlot0.addEventListener("out", this);
        this._btnSlot1.addEventListener("out", this);
        this._btnSlot2.addEventListener("out", this);
        this._btnSlot3.addEventListener("out", this);
        this._btnSlot4.addEventListener("out", this);
        this._btnSlot5.addEventListener("out", this);
        this._btnSlot6.addEventListener("out", this);
        this._btnSlot7.addEventListener("out", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblCrafts.text = this.api.lang.getText("RECEIPTS");
        this._lblFilter.text = this.api.lang.getText("FILTER");
    };
    _loc1.layoutContent = function ()
    {
        var _loc2 = this.api.datacenter.Basics.craftViewer_filter;
        this._btnSlot0.selected = _loc2[0];
        this._btnSlot1.selected = _loc2[1];
        this._btnSlot2.selected = _loc2[2];
        this._btnSlot3.selected = _loc2[3];
        this._btnSlot4.selected = _loc2[4];
        this._btnSlot5.selected = _loc2[5];
        this._btnSlot6.selected = _loc2[6];
        this._btnSlot7.selected = _loc2[7];
        if (this._oJob == undefined)
        {
            return;
        } // end if
        var _loc3 = this._oJob.crafts;
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc3.length)
        {
            var _loc6 = _loc3[_loc5];
            if (_loc2[_loc6.itemsCount - 1])
            {
                _loc4.push(_loc6);
            } // end if
        } // end while
        if (_loc4.length != 0)
        {
            this._lstCrafts._visible = true;
            _loc4.bubbleSortOn("itemsCount", Array.DESCENDING);
            this._lstCrafts.dataProvider = _loc4;
            this._lblNoCraft.text = "";
        }
        else
        {
            this._lstCrafts._visible = false;
            this._lblNoCraft.text = this.api.lang.getText("NO_CRAFT_AVAILABLE");
        } // end else if
    };
    _loc1.craftItem = function (oItem)
    {
        this._parent.addCraft(oItem.unicID);
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = this.api.datacenter.Basics.craftViewer_filter;
        var _loc4 = Number(oEvent.target._name.substr(8));
        _loc3[_loc4] = oEvent.target.selected;
        this.layoutContent();
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = Number(oEvent.target._name.substr(8)) + 1;
        this.gapi.showTooltip(this.api.lang.getText("CRAFT_SLOT_FILTER", [_loc3]), oEvent.target, -20);
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("skill", function ()
    {
    }, _loc1.__set__skill);
    _loc1.addProperty("job", function ()
    {
    }, _loc1.__set__job);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.CraftViewer = function ()
    {
        super();
    }).CLASS_NAME = "CraftViewer";
} // end if
#endinitclip
