// Action script...

// [Initial MovieClip Action of sprite 20970]
#initclip 235
if (!dofus.graphics.gapi.ui.crafterlist.CrafterListItem)
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
    if (!dofus.graphics.gapi.ui.crafterlist)
    {
        _global.dofus.graphics.gapi.ui.crafterlist = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.crafterlist.CrafterListItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = oItem;
            oItem.sortName = oItem.name;
            oItem.sortLevel = oItem.job.level;
            oItem.sortIsNotFree = oItem.job.options.isNotFree;
            oItem.sortMinSlots = Number(oItem.job.options.minSlots);
            oItem.sortSubarea = oItem.subarea == undefined ? ("-") : (oItem.subarea);
            var _loc5 = oItem.coord;
            oItem.sortCoord = _loc5 != undefined ? (_loc5.x + "," + _loc5.y) : ("-");
            oItem.sortInWorkshop = oItem.inWorkshop;
            this._lblName.text = oItem.sortName;
            this._lblLevel.text = oItem.sortLevel.toString();
            this._lblPlace.text = oItem.subarea == undefined ? (" ") : (oItem.subarea);
            var _loc6 = this._mcList._parent._parent.api;
            this._lblWorkshop.text = oItem.sortInWorkshop ? (_loc6.lang.getText("YES")) : (_loc6.lang.getText("NO"));
            this._lblCoord.text = oItem.sortCoord;
            this._lblNotFree.text = oItem.sortIsNotFree ? (_loc6.lang.getText("YES")) : (_loc6.lang.getText("NO"));
            this._lblMinSlot.text = oItem.sortMinSlots.toString();
            this._ldrGuild.contentPath = oItem.gfxBreedFile;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._lblPlace.text = "";
            this._lblWorkshop.text = "";
            this._lblCoord.text = "";
            this._lblNotFree.text = "";
            this._lblMinSlot.text = "";
            this._ldrGuild.contentPath = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnProfil.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnProfil":
            {
                this._mcList.gapi.loadUIComponent("CrafterCard", "CrafterCard", {crafter: this._oItem});
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
