// Action script...

// [Initial MovieClip Action of sprite 20758]
#initclip 23
if (!dofus.graphics.gapi.controls.AlignmentViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.AlignmentViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__enable = function (b)
    {
        this._lblAlignment._visible = b;
        this._pbAlignment._visible = b;
        this._mcAlignment._visible = b;
        //return (this.enable());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.AlignmentViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this._pbAlignment._visible = false;
        this._lblAlignment._visible = false;
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("ALIGNMENT");
        this._lblAlignment.text = this.api.lang.getText("LEVEL");
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("alignmentChanged", this);
    };
    _loc1.initData = function ()
    {
        this._sCurrentTab = "Specialization";
        this.alignmentChanged({alignment: this.api.datacenter.Player.alignment});
    };
    _loc1.updateCurrentTabInformations = function ()
    {
        this._mcTab.removeMovieClip();
        switch (this._sCurrentTab)
        {
            case "Specialization":
            {
                this.attachMovie("SpecializationViewer", "_mcTab", this.getNextHighestDepth(), {_x: this._mcTabPlacer._x, _y: this._mcTabPlacer._y});
                break;
            } 
            case "Rank":
            {
                this.attachMovie("RankViewer", "_mcTab", this.getNextHighestDepth(), {_x: this._mcTabPlacer._x, _y: this._mcTabPlacer._y});
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
    _loc1.alignmentChanged = function (oEvent)
    {
        this._mcTab.removeMovieClip();
        this._ldrIcon.contentPath = oEvent.alignment.iconFile;
        this._lblTitle.text = this.api.lang.getText("ALIGNMENT") + " " + oEvent.alignment.name;
        if (this.api.datacenter.Player.alignment.index != 0)
        {
            this.enable = true;
            this._lblNoAlignement.text = "";
            this._pbAlignment.value = oEvent.alignment.value;
            this._mcAlignment.onRollOver = function ()
            {
                this._parent.gapi.showTooltip(new ank.utils.ExtendedString(oEvent.alignment.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3) + " / " + new ank.utils.ExtendedString(this._parent._pbAlignment.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3), this, -10);
            };
            this._mcAlignment.onRollOut = function ()
            {
                this._parent.gapi.hideTooltip();
            };
            this.setCurrentTab(this._sCurrentTab);
        }
        else if (this._lblNoAlignement.text != undefined)
        {
            this.enable = false;
            this._lblNoAlignement.text = this.api.lang.getText("NO_ALIGNEMENT");
        } // end else if
    };
    _loc1.addProperty("enable", function ()
    {
    }, _loc1.__set__enable);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.AlignmentViewer = function ()
    {
        super();
    }).CLASS_NAME = "AlignmentViewer";
    _loc1._sCurrentTab = "Specialization";
} // end if
#endinitclip
