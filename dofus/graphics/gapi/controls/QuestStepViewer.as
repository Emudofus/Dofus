// Action script...

// [Initial MovieClip Action of sprite 20752]
#initclip 17
if (!dofus.graphics.gapi.controls.QuestStepViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.QuestStepViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__step = function (oStep)
    {
        this._oStep = oStep;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.step());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.QuestStepViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.updateData});
        this._btnDialog._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._btnDialog.addEventListener("click", this);
        this._btnDialog.addEventListener("over", this);
        this._btnDialog.addEventListener("out", this);
        this._lstObjectives.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblObjectives.text = this.api.lang.getText("QUESTS_OBJECTIVES");
        this._lblStep.text = this.api.lang.getText("STEP");
        this._lblRewards.text = this.api.lang.getText("QUESTS_REWARDS");
    };
    _loc1.updateData = function ()
    {
        if (this._oStep != undefined)
        {
            this._lblStep.text = this.api.lang.getText("STEP") + " : " + this._oStep.name;
            this._txtDescription.text = this._oStep.description;
            this._lstObjectives.dataProvider = this._oStep.objectives;
            this._lstRewards.dataProvider = this._oStep.rewards;
            this._btnDialog._visible = this._oStep.dialogID != undefined;
        } // end if
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = this._oStep.dialogID;
        var _loc4 = this._oStep.dialogParams;
        var _loc5 = new dofus.datacenter.Question(_loc3, undefined, _loc4);
        this.gapi.showTooltip(this.api.lang.getText("STEP_DIALOG") + " :\n\n" + _loc5.label, oEvent.target, 20);
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = this._oStep.dialogID;
        var _loc4 = this._oStep.dialogParams;
        var _loc5 = new dofus.datacenter.Question(_loc3, undefined, _loc4);
        this.api.kernel.showMessage(this.api.lang.getText("STEP_DIALOG"), _loc5.label, "ERROR_BOX");
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item;
        if (_loc3.x != undefined && _loc3.y != undefined)
        {
            this.api.kernel.GameManager.updateCompass(_loc3.x, _loc3.y);
        } // end if
    };
    _loc1.addProperty("step", function ()
    {
    }, _loc1.__set__step);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.QuestStepViewer = function ()
    {
        super();
    }).CLASS_NAME = "QuestStepViewer";
} // end if
#endinitclip
