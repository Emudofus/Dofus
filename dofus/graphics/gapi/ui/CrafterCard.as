// Action script...

// [Initial MovieClip Action of sprite 20542]
#initclip 63
if (!dofus.graphics.gapi.ui.CrafterCard)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.CrafterCard = function ()
    {
        super();
        this._bInit = false;
    }).prototype;
    _loc1.__set__crafter = function (oCrafter)
    {
        this._oCrafter = oCrafter;
        if (this._bInit)
        {
            this.updateData();
        } // end if
        //return (this.crafter());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.CrafterCard.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("CRAFTER");
        this._btnClose2.label = this.api.lang.getText("CLOSE");
        this._btnPrivateMessage.label = this.api.lang.getText("WISPER_MESSAGE");
        this._btnLocate.label = this.api.lang.getText("LOCATE");
        this._lblName.text = this.api.lang.getText("NAME_BIG");
        this._lblJob.text = this.api.lang.getText("CRAFT");
        this._lblJobLevel.text = this.api.lang.getText("JOB_LEVEL");
        this._lblLocalization.text = this.api.lang.getText("LOCALISATION");
        this._lblSubarea.text = this.api.lang.getText("SUBAREA");
        this._lblWorkshop.text = this.api.lang.getText("IN_WORKSHOP");
        this._lblCoord.text = this.api.lang.getText("COORDINATES");
        this._lblJobOptions.text = this.api.lang.getText("JOB_OPTIONS");
        this._lbNotFree.text = this.api.lang.getText("NOT_FREE");
        this._lblFreeIfFailed.text = this.api.lang.getText("FREE_IF_FAILED");
        this._lblRessourcesNeeded.text = this.api.lang.getText("CRAFT_RESSOURCES_NEEDED");
        this._lblMinSlots.text = this.api.lang.getText("MIN_ITEM_IN_RECEIPT");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose2.addEventListener("click", this);
        this._btnLocate.addEventListener("click", this);
        this._btnPrivateMessage.addEventListener("click", this);
        this._ldrSprite.addEventListener("initialization", this);
    };
    _loc1.updateData = function ()
    {
        this._bInit = true;
        var _loc2 = true;
        if (this._oCrafter != undefined)
        {
            this._ldrSprite.forceNextLoad();
            this._ldrSprite.contentPath = this._oCrafter.gfxFile == undefined ? ("") : (this._oCrafter.gfxFile);
            this.api.colors.addSprite(this._ldrSprite, this._oCrafter);
            this._lblNameValue.text = this._oCrafter.name;
            this._lblJobValue.text = this._oCrafter.job.name;
            this._lblJobLevelValue.text = this._oCrafter.job.level.toString();
            this._lblSubareaValue.text = this._oCrafter.subarea == undefined ? (this.api.lang.getText("OUTSIDE_WORKSHOP")) : (this._oCrafter.subarea);
            this._lblWorkshopValue.text = this._oCrafter.inWorkshop ? (this.api.lang.getText("YES")) : (this.api.lang.getText("NO"));
            var _loc3 = this._oCrafter.coord;
            this._lblCoordValue.text = _loc3 == undefined ? ("-") : (_loc3.x + "," + _loc3.y);
            var _loc4 = this._oCrafter.job.options;
            this._btnNotFree.selected = _loc4.isNotFree;
            this._btnFreeIfFailed.selected = _loc4.isFreeIfFailed;
            this._btnRessourcesNeeded.selected = _loc4.ressourcesNeeded;
            this._lblMinSlotsValue.text = _loc4.minSlots.toString();
            _loc2 = this._oCrafter.subarea != undefined;
        }
        else
        {
            this._ldrSprite.contentPath = "";
            this._lblNameValue.text = "-";
            this._lblJobValue.text = "-";
            this._lblJobLevelValue.text = "-";
            this._lblSubareaValue.text = "-";
            this._lblWorkshopValue.text = "-";
            this._lblCoordValue.text = "-";
            this._lblMinSlotsValue.text = "-";
            this._btnNotFree.selected = false;
            this._btnFreeIfFailed.selected = false;
            this._btnRessourcesNeeded.selected = false;
            this._lblMinSlotsValue.text = "-";
            _loc2 = false;
        } // end else if
        this._btnLocate._visible = _loc2;
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target.content;
        _loc3.attachMovie("staticF", "anim", 10);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose2":
            case "_btnClose":
            {
                this.unloadThis();
                break;
            } 
            case "_btnPrivateMessage":
            {
                this.api.kernel.GameManager.askPrivateMessage(this._oCrafter.name);
                break;
            } 
            case "_btnLocate":
            {
                var _loc3 = this._oCrafter.coord;
                this.api.kernel.GameManager.updateCompass(_loc3.x, _loc3.y, true);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("crafter", function ()
    {
    }, _loc1.__set__crafter);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.CrafterCard = function ()
    {
        super();
        this._bInit = false;
    }).CLASS_NAME = "CrafterCard";
} // end if
#endinitclip
