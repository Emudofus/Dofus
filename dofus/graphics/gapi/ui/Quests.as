// Action script...

// [Initial MovieClip Action of sprite 20813]
#initclip 78
if (!dofus.graphics.gapi.ui.Quests)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Quests = function ()
    {
        super();
    }).prototype;
    _loc1.setPendingCount = function (nCount)
    {
        this._lblQuestCount.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("PENDING_QUEST", [nCount]), "m", nCount < 2);
    };
    _loc1.setStep = function (oStep)
    {
        this.showStepViewer(true);
        this._oCurrentStep = oStep;
        if (this._sCurrentTab == "Current")
        {
            this._mcTab.step = oStep;
        }
        else
        {
            this.setCurrentTab("Current");
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Quests.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
        delete this.api.datacenter.Temporary.QuestBook;
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.addListeners});
        this.showStepViewer(false);
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("QUESTS_LIST");
        this._winBgViewer.title = this.api.lang.getText("STEPS");
        this._btnTabCurrent.label = this.api.lang.getText("QUESTS_CURRENT_STEP");
        this._btnTabAll.label = this.api.lang.getText("QUESTS_STEPS_LIST");
        this._dgQuests.columnsNames = [this.api.lang.getText("STATE"), this.api.lang.getText("NAME_BIG")];
        this._lblFinished.text = this.api.lang.getText("DISPLAY_FINISHED_QUESTS");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnCloseStep.addEventListener("click", this);
        this._btnTabCurrent.addEventListener("click", this);
        this._btnTabAll.addEventListener("click", this);
        this._btnFinished.addEventListener("click", this);
        this._dgQuests.addEventListener("itemSelected", this);
        this.api.datacenter.Temporary.QuestBook.quests.addEventListener("modelChanged", this);
    };
    _loc1.initData = function ()
    {
        if (this.api.datacenter.Temporary.QuestBook == undefined)
        {
            this.api.datacenter.Temporary.QuestBook = new dofus.datacenter.QuestBook();
        } // end if
        this.api.network.Quests.getList();
    };
    _loc1.showStepViewer = function (bShow)
    {
        if (bShow)
        {
            this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_QUEST_WALKTHOUGH);
        } // end if
        this._btnCloseStep._visible = bShow;
        this._winBgViewer._visible = bShow;
        this._mcTab._visible = bShow;
        this._btnTabCurrent._visible = bShow;
        this._btnTabAll._visible = bShow;
        this._mcBackButtons._visible = bShow;
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        this._mcTab.removeMovieClip();
        switch (this._sCurrentTab)
        {
            case "Current":
            {
                this.attachMovie("QuestStepViewer", "_mcTab", this.getNextHighestDepth(), {_x: this._mcTabPlacer._x, _y: this._mcTabPlacer._y, step: this._oCurrentStep});
                break;
            } 
            case "All":
            {
                this.attachMovie("QuestStepListViewer", "_mcTab", this.getNextHighestDepth(), {_x: this._mcTabPlacer._x, _y: this._mcTabPlacer._y, steps: this._oCurrentStep.allSteps});
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
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnTabCurrent":
            {
                this.setCurrentTab("Current");
                break;
            } 
            case "_btnTabAll":
            {
                this.setCurrentTab("All");
                break;
            } 
            case "_btnFinished":
            {
                this.modelChanged();
                break;
            } 
            case "_btnCloseStep":
            {
                this._dgQuests.selectedIndex = -1;
                this.showStepViewer(false);
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item;
        if (_loc3.isFinished)
        {
            this.showStepViewer(false);
        }
        else
        {
            var _loc4 = _loc3.currentStep;
            this._winBgViewer.title = _loc3.name;
            if (_loc4 != undefined)
            {
                this.setStep(_loc4);
            }
            else
            {
                this.api.network.Quests.getStep(_loc3.id);
            } // end else if
            this.api.datacenter.Basics.quests_lastID = _loc3.id;
        } // end else if
    };
    _loc1.modelChanged = function (oEvent)
    {
        var _loc3 = this.api.datacenter.Temporary.QuestBook.quests;
        var _loc4 = new ank.utils.ExtendedArray();
        if (this._btnFinished.selected)
        {
            _loc4 = _loc3;
        }
        else
        {
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc3.length)
            {
                if (!_loc3[_loc5].isFinished)
                {
                    _loc4.push(_loc3[_loc5]);
                } // end if
            } // end while
        } // end else if
        this._dgQuests.dataProvider = _loc4;
        this._dgQuests.sortOn("sortOrder", Array.NUMERIC);
        if (this.api.datacenter.Basics.quests_lastID != undefined)
        {
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < this._dgQuests.dataProvider.length)
            {
                var _loc7 = this._dgQuests.dataProvider[_loc6];
                if (_loc7.id == this.api.datacenter.Basics.quests_lastID)
                {
                    this._dgQuests.selectedIndex = _loc6;
                    this.api.network.Quests.getStep(_loc7.id);
                    break;
                } // end if
            } // end while
        } // end if
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Quests = function ()
    {
        super();
    }).CLASS_NAME = "Quests";
} // end if
#endinitclip
