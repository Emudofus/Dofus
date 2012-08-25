// Action script...

// [Initial MovieClip Action of sprite 20724]
#initclip 245
if (!dofus.graphics.gapi.ui.SpellForget)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.SpellForget = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.SpellForget.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._btnValidate.enabled = false;
        this._btnClose.addEventListener("click", this);
        this._btnCancel.addEventListener("click", this);
        this._btnValidate.addEventListener("click", this);
        this._lstSpells.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("SPELL_FORGET");
        this._lblName.text = this.api.lang.getText("SPELLS_SHORTCUT");
        this._lblLevel.text = this.api.lang.getText("LEVEL");
        this._btnValidate.label = this.api.lang.getText("VALIDATE");
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.datacenter.Player.Spells;
        var _loc3 = new ank.utils.ExtendedArray();
        for (var k in _loc2)
        {
            var _loc4 = _loc2[k];
            if (_loc4.classID != -1 && _loc4.level > 1)
            {
                _loc3.push(_loc4);
            } // end if
        } // end of for...in
        this._lstSpells.dataProvider = _loc3;
    };
    _loc1.itemSelected = function (oEvent)
    {
        this._btnValidate.enabled = true;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnValidate:
            {
                var _loc3 = (dofus.datacenter.Spell)(this._lstSpells.selectedItem);
                this.api.kernel.showMessage(this.api.lang.getText("SPELL_FORGET"), this.api.lang.getText("SPELL_FORGET_CONFIRM", [_loc3.name]), "CAUTION_YESNO", {name: "SpellForget", listener: this, params: {spell: _loc3}});
                break;
            } 
            case this._btnClose:
            case this._btnCancel:
            {
                this.api.network.Spells.spellForget(-1);
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoSpellForget":
            {
                var _loc3 = oEvent.target.params.spell;
                this.api.network.Spells.spellForget(_loc3.ID);
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.SpellForget = function ()
    {
        super();
    }).CLASS_NAME = "SpellForget";
} // end if
#endinitclip
