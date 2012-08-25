// Action script...

// [Initial MovieClip Action of sprite 20625]
#initclip 146
if (!dofus.graphics.gapi.controls.ClassInfosViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.ClassInfosViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__classID = function (nClassID)
    {
        this._nClassID = nClassID;
        this.addToQueue({object: this, method: this.layoutContent});
        //return (this.classID());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ClassInfosViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initTexts = function ()
    {
        this._lblClassSpells.text = this.api.lang.getText("CLASS_SPELLS");
    };
    _loc1.addListeners = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 20)
        {
            this["_ctr" + _loc2].addEventListener("over", this);
            this["_ctr" + _loc2].addEventListener("out", this);
            this["_ctr" + _loc2].addEventListener("click", this);
        } // end while
    };
    _loc1.layoutContent = function ()
    {
        var _loc2 = dofus.Constants.SPELLS_ICONS_PATH;
        var _loc3 = this.api.lang.getClassText(this._nClassID).s;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < 20)
        {
            var _loc5 = this["_ctr" + _loc4];
            _loc5.contentPath = _loc2 + _loc3[_loc4] + ".swf";
            _loc5.params = {spellID: _loc3[_loc4]};
        } // end while
        this._txtDescription.text = this.api.lang.getClassText(this._nClassID).d;
        this.showSpellInfos(_loc3[0]);
    };
    _loc1.showSpellInfos = function (nSpellID)
    {
        var _loc3 = this.api.kernel.CharactersManager.getSpellObjectFromData(nSpellID + "~1~");
        if (_loc3.name == undefined)
        {
            this._lblSpellName.text = "";
            this._lblSpellRange.text = "";
            this._lblSpellAP.text = "";
            this._txtSpellDescription.text = "";
            this._ldrSpellIcon.contentPath = "";
        }
        else if (this._lblSpellName.text != undefined)
        {
            this._lblSpellName.text = _loc3.name;
            this._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + _loc3.rangeStr;
            this._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + _loc3.apCost;
            this._txtSpellDescription.text = _loc3.description + "\n" + _loc3.descriptionNormalHit;
            this._ldrSpellIcon.contentPath = _loc3.iconFile;
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        this.showSpellInfos(oEvent.target.params.spellID);
    };
    _loc1.addProperty("classID", function ()
    {
    }, _loc1.__set__classID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ClassInfosViewer = function ()
    {
        super();
    }).CLASS_NAME = "ClassInfosViewer";
} // end if
#endinitclip
