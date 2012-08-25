// Action script...

// [Initial MovieClip Action of sprite 20644]
#initclip 165
if (!dofus.graphics.gapi.controls.JobViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.JobViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__job = function (oJob)
    {
        this._oJob = oJob;
        this.addToQueue({object: this, method: this.layoutContent});
        //return (this.job());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.JobViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._lblNoTool._visible = false;
        this._mcPlacer._visible = false;
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initTexts = function ()
    {
        this._lblXP.text = this.api.lang.getText("EXPERIMENT");
        this._lblSkill.text = this.api.lang.getText("SKILLS");
        this._lblTool.text = this.api.lang.getText("TOOL");
        this._lblNoTool.text = this.api.lang.getText("NO_TOOL_JOB");
        this._btnTabCharacteristics.label = this.api.lang.getText("CHARACTERISTICS");
        this._btnTabCrafts.label = this.api.lang.getText("RECEIPTS");
        this._btnTabOptions.label = this.api.lang.getText("OPTIONS");
    };
    _loc1.addListeners = function ()
    {
        this._btnTabCharacteristics.addEventListener("click", this);
        this._btnTabCrafts.addEventListener("click", this);
        this._btnTabOptions.addEventListener("click", this);
    };
    _loc1.layoutContent = function ()
    {
        if (this._oJob == undefined)
        {
            return;
        } // end if
        this.setCurrentTab(this._sCurrentTab);
        this._lstSkills.removeMovieClip();
        var _loc2 = this.api.datacenter.Player.currentJobID == this._oJob.id;
        this._ldrIcon.contentPath = this._oJob.iconFile;
        this._lblName.text = this._oJob.name;
        this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oJob.level;
        this._pbXP.minimum = this._oJob.xpMin;
        this._pbXP.maximum = this._oJob.xpMax;
        this._pbXP.value = this._oJob.xp;
        this._mcXP.onRollOver = function ()
        {
            this._parent._parent.gapi.showTooltip(new ank.utils.ExtendedString(this._parent._oJob.xp).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._oJob.xpMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
        };
        this._mcXP.onRollOut = function ()
        {
            this._parent._parent.gapi.hideTooltip();
        };
        var _loc3 = this._oJob.skills;
        if (_loc3.length != 0)
        {
            _loc3.sortOn("skillName");
            this._lstSkills.dataProvider = _loc3;
        } // end if
        if (_loc2)
        {
            this._lblNoTool._visible = false;
            this._itvItemViewer._visible = true;
            var _loc4 = this.api.datacenter.Player.Inventory.findFirstItem("position", 1).item;
            this._itvItemViewer.itemData = _loc4;
        }
        else
        {
            this._lblNoTool._visible = true;
            this._itvItemViewer._visible = false;
        } // end else if
    };
    _loc1.showCraftViewer = function (bShow)
    {
        if (bShow)
        {
            var _loc3 = this.attachMovie("CraftViewer", "_cvCraftViewer", 20);
            _loc3._x = this._mcPlacer._x;
            _loc3._y = this._mcPlacer._y;
            _loc3.job = this._oJob;
        }
        else
        {
            this._cvCraftViewer.removeMovieClip();
        } // end else if
    };
    _loc1.showOptionViewer = function (bShow)
    {
        if (bShow)
        {
            var _loc3 = this.attachMovie("JobOptionsViewer", "_jovJobOptionsViewer", 20);
            _loc3._x = this._mcPlacer._x;
            _loc3._y = this._mcPlacer._y;
            _loc3.job = this._oJob;
        }
        else
        {
            this._jovJobOptionsViewer.removeMovieClip();
        } // end else if
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        switch (this._sCurrentTab)
        {
            case "Characteristics":
            {
                this.showOptionViewer(false);
                this.showCraftViewer(false);
                break;
            } 
            case "Crafts":
            {
                this.showOptionViewer(false);
                this.showCraftViewer(true);
                break;
            } 
            case "Options":
            {
                this.showCraftViewer(false);
                this.showOptionViewer(true);
                break;
            } 
        } // End of switch
    };
    _loc1.setCurrentTab = function (sNewTab)
    {
        var _loc3 = this["_btnTab" + this._sCurrentTab];
        var _loc4 = this["_btnTab" + sNewTab];
        _loc3.selected = true;
        _loc3.enabled = true;
        _loc4.selected = false;
        _loc4.enabled = false;
        this._sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnTabCharacteristics":
            {
                this.setCurrentTab("Characteristics");
                break;
            } 
            case "_btnTabCrafts":
            {
                this.setCurrentTab("Crafts");
                break;
            } 
            case "_btnTabOptions":
            {
                this.setCurrentTab("Options");
            } 
        } // End of switch
    };
    _loc1.addProperty("job", function ()
    {
    }, _loc1.__set__job);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.JobViewer = function ()
    {
        super();
    }).CLASS_NAME = "JobViewer";
    _loc1._sCurrentTab = "Characteristics";
} // end if
#endinitclip
