// Action script...

// [Initial MovieClip Action of sprite 20794]
#initclip 59
if (!dofus.graphics.gapi.controls.SpellBoostViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.SpellBoostViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__spell = function (oSpell)
    {
        this._oSpell = oSpell;
        if (this.initialized)
        {
            this.initData();
        } // end if
        //return (this.spell());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.SpellBoostViewer.CLASS_NAME);
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
        this._lblNew.text = this.api.lang.getText("NEW_CHARACTERISTICS");
    };
    _loc1.updateData = function ()
    {
        if (this._oSpell != undefined)
        {
            this._ldrIcon.contentPath = this._oSpell.iconFile;
            this._lblName.text = this._oSpell.name;
            this._lblLevel1.text = this.api.lang.getText("LEVEL") + " " + this._oSpell.level;
            this._lblAP1.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
            this._lblRange1.text = this._oSpell.rangeStr + " " + this.api.lang.getText("RANGE");
            this._txtDamages1.text = this._oSpell.descriptionNormalHit;
            this._txtCritical1.text = this._oSpell.descriptionCriticalHit == undefined ? ("") : (this._oSpell.descriptionCriticalHit);
            this._mcArrowCritical._visible = this._oSpell.descriptionCriticalHit != undefined;
            this._oSpell.level = this._oSpell.level + 1;
            this._lblLevel2.text = this.api.lang.getText("LEVEL") + " " + this._oSpell.level;
            this._lblAP2.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
            this._lblRange2.text = this._oSpell.rangeStr + " " + this.api.lang.getText("RANGE");
            this._txtDamages2.text = this._oSpell.descriptionNormalHit;
            this._txtCritical2.text = this._oSpell.descriptionCriticalHit == undefined ? ("") : (this._oSpell.descriptionCriticalHit);
            this._oSpell.level = this._oSpell.level - 1;
        } // end if
    };
    _loc1.addProperty("spell", function ()
    {
    }, _loc1.__set__spell);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.SpellBoostViewer = function ()
    {
        super();
    }).CLASS_NAME = "SpellBoostViewer";
} // end if
#endinitclip
