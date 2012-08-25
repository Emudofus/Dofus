// Action script...

// [Initial MovieClip Action of sprite 20628]
#initclip 149
if (!dofus.graphics.gapi.ui.playerinfos.PlayerInfosEffectsItem)
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
    if (!dofus.graphics.gapi.ui.playerinfos)
    {
        _global.dofus.graphics.gapi.ui.playerinfos = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.playerinfos.PlayerInfosEffectsItem = function ()
    {
        super();
        this.api = _global.API;
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._ldrIcon.forceNextLoad();
            this._ldrIcon.contentPath = dofus.Constants.EFFECTSICON_FILE;
            this._lblDescription.text = oItem.description;
            this._lblRemainingTurn.text = oItem.remainingTurnStr;
            this._lblSpell.text = oItem.spellName;
            var ref = this;
            this._mcInteractivity.onRollOver = function ()
            {
                ref.over({target: this});
            };
            this._mcInteractivity.onRollOut = function ()
            {
                ref.out({target: this});
            };
            this._oItem = oItem;
        }
        else if (this._lblSpell.text != undefined)
        {
            this._ldrIcon.contentPath = "";
            this._lblDescription.text = "";
            this._lblRemainingTurn.text = "";
            this._lblSpell.text = "";
            delete this._mcInteractivity.onRollOver;
            delete this._mcInteractivity.onRollOut;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._ldrIcon.addEventListener("initialization", this);
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = this._ldrIcon.content.attachMovie("Icon_" + this._oItem.characteristic, "_mcIcon", 10, {operator: this._oItem.operator});
        _loc3.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
        var _loc4 = (dofus.graphics.battlefield.EffectIcon)(_loc3);
        _loc4.initialize(this._oItem.operator, 1);
    };
    _loc1.over = function (event)
    {
        switch (event.target)
        {
            case this._mcInteractivity:
            {
                if (this._oItem.spellDescription.length > 0)
                {
                    this.api.ui.showTooltip(this._oItem.spellDescription, _root._xmouse, _root._ymouse - 30);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (event)
    {
        this.api.ui.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
