// Action script...

// [Initial MovieClip Action of sprite 20711]
#initclip 232
if (!dofus.graphics.gapi.controls.SpellInfosViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.SpellInfosViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__spell = function (oSpell)
    {
        if (oSpell == this._oSpell)
        {
            return;
        } // end if
        this._oSpell = oSpell;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.spell());
    };
    _loc1.__get__spell = function ()
    {
        return (this._oSpell);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.SpellInfosViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.initData = function ()
    {
        this.updateData();
    };
    _loc1.initTexts = function ()
    {
        this._lblEffectsTitle.text = this.api.lang.getText("EFFECTS") + " :";
        this._lblCriticalHitTitle.text = this.api.lang.getText("CRITICAL_HIT") + " :";
        this._lblHelp.text = this.api.lang.getText("HOW_GET_DETAILS");
    };
    _loc1.updateData = function ()
    {
        if (this._oSpell != undefined)
        {
            this._lblCriticalHitTitle._visible = this._oSpell.descriptionCriticalHit != undefined;
            this._lblName.text = this._oSpell.name;
            this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oSpell.level;
            this._lblRange.text = (this._oSpell.rangeMin != 0 ? (this._oSpell.rangeMin + "-") : ("")) + this._oSpell.rangeMax + " " + this.api.lang.getText("RANGE");
            this._lblAP.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
            this._txtDescription.text = this._oSpell.description;
            this._txtEffects.text = this._oSpell.descriptionNormalHit;
            this._txtCriticalHit.text = this._oSpell.descriptionCriticalHit != undefined ? (this._oSpell.descriptionCriticalHit) : ("");
            this._ldrIcon.contentPath = this._oSpell.iconFile;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblCriticalHitTitle._visible = false;
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._lblRange.text = "";
            this._lblAP.text = "";
            this._txtDescription.text = "";
            this._txtEffects.text = "";
            this._txtCriticalHit.text = "";
            this._ldrIcon.contentPath = "";
        } // end else if
    };
    _loc1.addProperty("spell", _loc1.__get__spell, _loc1.__set__spell);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.SpellInfosViewer = function ()
    {
        super();
    }).CLASS_NAME = "SpellInfosViewer";
} // end if
#endinitclip
