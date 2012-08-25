// Action script...

// [Initial MovieClip Action of sprite 20523]
#initclip 44
if (!dofus.graphics.gapi.controls.QuestStepListViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.QuestStepListViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__steps = function (eaSteps)
    {
        this._eaSteps = eaSteps;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.steps());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.QuestStepListViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._lstSteps.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblSteps.text = this.api.lang.getText("QUESTS_ALL_STEPS");
    };
    _loc1.updateData = function ()
    {
        if (this._eaSteps != undefined)
        {
            this._lstSteps.dataProvider = this._eaSteps;
            var _loc2 = 0;
            
            while (++_loc2, _loc2 < this._eaSteps.length)
            {
                if (this._eaSteps[_loc2].isCurrent)
                {
                    this._lstSteps.selectedIndex = _loc2;
                    this._txtDescription.text = this._eaSteps[_loc2].description;
                    break;
                } // end if
            } // end while
        } // end if
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item;
        this._txtDescription.text = _loc3.description;
    };
    _loc1.addProperty("steps", function ()
    {
    }, _loc1.__set__steps);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.QuestStepListViewer = function ()
    {
        super();
    }).CLASS_NAME = "QuestStepListViewer";
} // end if
#endinitclip
