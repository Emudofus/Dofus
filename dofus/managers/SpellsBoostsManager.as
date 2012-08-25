// Action script...

// [Initial MovieClip Action of sprite 20889]
#initclip 154
if (!dofus.managers.SpellsBoostsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.SpellsBoostsManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        this.clear();
    };
    _loc1.clear = function ()
    {
        this._oSpellsModificators = new Object();
        delete dofus.managers.SpellsBoostsManager._aBoostedEffects;
        delete dofus.managers.SpellsBoostsManager._aDamagingEffects;
        delete dofus.managers.SpellsBoostsManager._aHealingEffects;
    };
    _loc1.getSpellModificator = function (actionId, spellId)
    {
        if (_global.isNaN(this._oSpellsModificators[actionId][spellId]) || this._oSpellsModificators[actionId][spellId] == undefined)
        {
            return (-1);
        } // end if
        return (Number(this._oSpellsModificators[actionId][spellId]));
    };
    _loc1.setSpellModificator = function (actionId, spellId, modificator)
    {
        if (typeof(this._oSpellsModificators[actionId]) != "object" && this._oSpellsModificators[actionId] == undefined)
        {
            this._oSpellsModificators[actionId] = new Object();
        } // end if
        this._oSpellsModificators[actionId][spellId] = modificator;
    };
    _loc1.isBoostedDamagingEffect = function (effectId)
    {
        if (dofus.managers.SpellsBoostsManager._aDamagingEffects == undefined)
        {
            this.computeBoostedEffectsLists();
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
        {
            if (dofus.managers.SpellsBoostsManager._aDamagingEffects[_loc3] == effectId)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.isBoostedHealingEffect = function (effectId)
    {
        if (dofus.managers.SpellsBoostsManager._aHealingEffects == undefined)
        {
            this.computeBoostedEffectsLists();
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
        {
            if (dofus.managers.SpellsBoostsManager._aHealingEffects[_loc3] == effectId)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.isBoostedHealingOrDamagingEffect = function (effectId)
    {
        if (dofus.managers.SpellsBoostsManager._aBoostedEffects == undefined)
        {
            this.computeBoostedEffectsLists();
        } // end if
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.managers.SpellsBoostsManager._aBoostedEffects.length)
        {
            if (dofus.managers.SpellsBoostsManager._aBoostedEffects[_loc3] == effectId)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    _loc1.computeBoostedEffectsLists = function ()
    {
        dofus.managers.SpellsBoostsManager._aBoostedEffects = new Array();
        dofus.managers.SpellsBoostsManager._aDamagingEffects = this.api.lang.getBoostedDamagingEffects();
        dofus.managers.SpellsBoostsManager._aHealingEffects = this.api.lang.getBoostedHealingEffects();
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
        {
            dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aDamagingEffects[_loc2]);
        } // end while
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
        {
            dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aHealingEffects[_loc3]);
        } // end while
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_RANGE = 281;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_RANGEABLE = 282;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_DMG = 283;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_HEAL = 284;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_AP_COST = 285;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_CAST_INTVL = 286;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_CC = 287;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_CASTOUTLINE = 288;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_NOLINEOFSIGHT = 289;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_MAXPERTURN = 290;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_MAXPERTARGET = 291;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    }).ACTION_BOOST_SPELL_SET_INTVL = 292;
    (_global.dofus.managers.SpellsBoostsManager = function (oAPI)
    {
        super();
        dofus.managers.SpellsBoostsManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
} // end if
#endinitclip
