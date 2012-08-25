// Action script...

// [Initial MovieClip Action of sprite 20492]
#initclip 13
if (!dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerVillageItem)
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
    if (!dofus.graphics.gapi.controls.conquestzonesviewer)
    {
        _global.dofus.graphics.gapi.controls.conquestzonesviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerVillageItem = function ()
    {
        super();
        this.api = _global.API;
        this._ldrAlignment._alpha = 0;
        this._mcNotAligned._alpha = 0;
        this._mcAlignmentInteractivity._alpha = 0;
        this._mcDoorClose._alpha = 0;
        this._mcDoorOpen._alpha = 0;
        this._mcDoorInteractivity._alpha = 0;
        this._mcPrismClose._alpha = 0;
        this._mcPrismOpen._alpha = 0;
        this._mcPrismInteractivity._alpha = 0;
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
            this._lblVillage.text = this.api.lang.getMapAreaText(oItem.id).n;
            if (oItem.alignment == -1)
            {
                this._ldrAlignment._alpha = 0;
                this._mcNotAligned._alpha = 100;
            }
            else
            {
                this._mcNotAligned._alpha = 0;
                this._ldrAlignment._alpha = 100;
                this._ldrAlignment.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignment + ".swf";
            } // end else if
            if (oItem.door)
            {
                this._mcDoorClose._alpha = 0;
                this._mcDoorOpen._alpha = 100;
            }
            else
            {
                this._mcDoorClose._alpha = 100;
                this._mcDoorOpen._alpha = 0;
            } // end else if
            if (oItem.prism)
            {
                this._mcPrismClose._alpha = 0;
                this._mcPrismOpen._alpha = 100;
            }
            else
            {
                this._mcPrismClose._alpha = 100;
                this._mcPrismOpen._alpha = 0;
            } // end else if
            var ref = this;
            this._mcAlignmentInteractivity.onRollOver = function ()
            {
                ref.over({target: this});
            };
            this._mcAlignmentInteractivity.onRollOut = function ()
            {
                ref.out({target: this});
            };
            this._mcDoorInteractivity.onRollOver = function ()
            {
                ref.over({target: this});
            };
            this._mcDoorInteractivity.onRollOut = function ()
            {
                ref.out({target: this});
            };
            this._mcPrismInteractivity.onRollOver = function ()
            {
                ref.over({target: this});
            };
            this._mcPrismInteractivity.onRollOut = function ()
            {
                ref.out({target: this});
            };
        }
        else if (this._lblVillage.text != undefined)
        {
            this._lblVillage.text = "";
            this._ldrAlignment._alpha = 0;
            this._ldrAlignment.contentPath = undefined;
            this._mcNotAligned._alpha = 0;
            this._mcAlignmentInteractivity._alpha = 0;
            this._mcDoorClose._alpha = 0;
            this._mcDoorOpen._alpha = 0;
            this._mcDoorInteractivity._alpha = 0;
            this._mcPrismClose._alpha = 0;
            this._mcPrismOpen._alpha = 0;
            this._mcPrismInteractivity._alpha = 0;
        } // end else if
    };
    _loc1.over = function (event)
    {
        switch (event.target)
        {
            case this._mcAlignmentInteractivity:
            {
                this.api.ui.showTooltip(this.api.lang.getText("ALIGNMENT") + ": " + (this._oItem.alignment > 0 ? (new dofus.datacenter.Alignment(this._oItem.alignment, 1).name) : (this._oItem.alignment == -1 ? (this.api.lang.getText("NON_ALIGNED")) : (this.api.lang.getText("NEUTRAL_WORD")))), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcDoorInteractivity:
            {
                this.api.ui.showTooltip(this._oItem.door ? (this.api.lang.getText("CONQUEST_VILLAGE_DOOR_OPEN")) : (this.api.lang.getText("CONQUEST_VILLAGE_DOOR_CLOSE")), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcPrismInteractivity:
            {
                this.api.ui.showTooltip(this._oItem.prism ? (this.api.lang.getText("CONQUEST_VILLAGE_PRISM_OPEN")) : (this.api.lang.getText("CONQUEST_VILLAGE_PRISM_CLOSE")), _root._xmouse, _root._ymouse - 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (event)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
