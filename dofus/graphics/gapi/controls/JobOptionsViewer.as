// Action script...

// [Initial MovieClip Action of sprite 20518]
#initclip 39
if (!dofus.graphics.gapi.controls.JobOptionsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.JobOptionsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__job = function (oJob)
    {
        this._oJob.removeEventListener("optionsChanged", this);
        this._oJob = oJob;
        this._oJob.addEventListener("optionsChanged", this);
        if (this.initialized)
        {
            this.optionsChanged();
        } // end if
        //return (this.job());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.JobOptionsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("craftPublicModeChanged", this);
        this._vsCraftComplexity.addEventListener("change", this);
        this._btnEnabled.addEventListener("click", this);
        this._btnEnabled.addEventListener("over", this);
        this._btnEnabled.addEventListener("out", this);
        this._btnValidate.addEventListener("click", this);
        this._btnNotFree.addEventListener("click", this);
        this._btnFreeIfFailed.addEventListener("click", this);
        this._btnRessourcesNeeded.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblReferencingOptions.text = this.api.lang.getText("REFERENCING_OPTIONS");
        this._lbNotFree.text = this.api.lang.getText("NOT_FREE");
        this._lblFreeIfFailed.text = this.api.lang.getText("FREE_IF_FAILED");
        this._lblRessourcesNeeded.text = this.api.lang.getText("CRAFT_RESSOURCES_NEEDED");
        this._lblCraftComplexity.text = this.api.lang.getText("MIN_ITEM_IN_RECEIPT");
        this._txtInfos.text = this.api.lang.getText("PUBLIC_MODE_INFOS");
        this._btnValidate.label = this.api.lang.getText("SAVE");
        this._btnValidate.enabled = false;
        this.craftPublicModeChanged();
    };
    _loc1.initData = function ()
    {
        this.optionsChanged();
    };
    _loc1.refreshBtnEnabledLabel = function ()
    {
        this._btnEnabled.label = this.api.datacenter.Player.craftPublicMode ? (this.api.lang.getText("DISABLE")) : (this.api.lang.getText("ENABLE"));
    };
    _loc1.refreshCraftComplexityLabel = function (nMinSlot)
    {
        this._lblCraftComplexityValue.text = nMinSlot.toString() + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("SLOT"), "m", nMinSlot < 2);
    };
    _loc1.change = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_vsCraftComplexity":
            {
                this.refreshCraftComplexityLabel(this._vsCraftComplexity.value);
                this._btnValidate.enabled = true;
                break;
            } 
        } // End of switch
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnEnabled":
            {
                this.api.network.Exchange.setPublicMode(!this.api.datacenter.Player.craftPublicMode);
                break;
            } 
            case "_btnValidate":
            {
                var _loc3 = this.api.datacenter.Player.Jobs.findFirstItem("id", this._oJob.id);
                if (_loc3.index != -1)
                {
                    var _loc4 = (this._btnNotFree.selected ? (1) : (0)) + (this._btnFreeIfFailed.selected ? (2) : (0)) + (this._btnRessourcesNeeded.selected ? (4) : (0));
                    this.api.network.Job.changeJobStats(_loc3.index, _loc4, this._vsCraftComplexity._visible == false ? (2) : (this._vsCraftComplexity.value));
                } // end if
                break;
            } 
            case "_btnNotFree":
            {
                this._btnFreeIfFailed.enabled = this._btnNotFree.selected ? (true) : (false);
            } 
            case "_btnFreeIfFailed":
            case "_btnRessourcesNeeded":
            {
                this._btnValidate.enabled = true;
                break;
            } 
        } // End of switch
    };
    _loc1.optionsChanged = function (oEvent)
    {
        if (this._oJob != undefined && this._btnNotFree.selected != undefined)
        {
            var _loc3 = this._oJob.options;
            var _loc4 = this._oJob.getMaxSkillSlot();
            _loc4 = _loc4 > 8 ? (8) : (_loc4);
            if (_loc4 > 2)
            {
                this._vsCraftComplexity._visible = true;
                this._vsCraftComplexity.markerCount = _loc4 - 1;
                this._vsCraftComplexity.min = 2;
                this._vsCraftComplexity.max = _loc4;
                this._vsCraftComplexity.redraw();
                this._vsCraftComplexity.value = _loc3.minSlots;
            }
            else
            {
                this._vsCraftComplexity._visible = false;
            } // end else if
            this.refreshCraftComplexityLabel(_loc3.minSlots);
            this._btnNotFree.selected = _loc3.isNotFree;
            this._btnFreeIfFailed.selected = _loc3.isFreeIfFailed;
            this._btnFreeIfFailed.enabled = this._btnNotFree.selected ? (true) : (false);
            this._btnRessourcesNeeded.selected = _loc3.ressourcesNeeded;
            this._btnValidate.enabled = false;
        } // end if
    };
    _loc1.craftPublicModeChanged = function (oEvent)
    {
        this._lblPublicMode.text = this.api.lang.getText("PUBLIC_MODE") + " (" + this.api.lang.getText(this.api.datacenter.Player.craftPublicMode ? ("ACTIVE") : ("INACTIVE")) + ")";
        this.refreshBtnEnabledLabel();
        this._mcPublicDisable._visible = !this.api.datacenter.Player.craftPublicMode;
        this._mcPublicEnable._visible = this.api.datacenter.Player.craftPublicMode;
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnEnabled:
            {
                var _loc3 = this.api.datacenter.Player.craftPublicMode ? (this.api.lang.getText("DISABLE_PUBLIC_MODE")) : (this.api.lang.getText("ENABLE_PUBLIC_MODE"));
                this.gapi.showTooltip(_loc3, oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("job", function ()
    {
    }, _loc1.__set__job);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.JobOptionsViewer = function ()
    {
        super();
    }).CLASS_NAME = "JobOptionsViewer";
} // end if
#endinitclip
