// Action script...

// [Initial MovieClip Action of sprite 837]
#initclip 49
class dofus.managers.CharacteristicsManager extends dofus.utils.ApiElement
{
    var _oSprite, _aEffects, _aModerators, api;
    function CharacteristicsManager(oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    } // End of the function
    function initialize(oSprite, oAPI)
    {
        super.initialize(oAPI);
        _oSprite = oSprite;
        _aEffects = new Array();
        _aModerators = new Array(20);
        for (var _loc3 = 0; _loc3 < _aModerators.length; ++_loc3)
        {
            _aModerators[_loc3] = 0;
        } // end of for
    } // End of the function
    function getEffects()
    {
        return (_aEffects);
    } // End of the function
    function getModeratorValue(nType)
    {
        nType = Number(nType);
        var _loc2 = Number(_aModerators[nType]);
        if (isNaN(_loc2))
        {
            return (0);
        }
        else
        {
            return (_loc2);
        } // end else if
    } // End of the function
    function addEffect(oEffect)
    {
        _aEffects.push(oEffect);
        this.onEffectStart(oEffect);
    } // End of the function
    function terminateAllEffects()
    {
        var _loc2 = _aEffects.length;
        var _loc3;
        while (--_loc2 >= 0)
        {
            _loc3 = _aEffects[_loc2];
            this.onEffectEnd(_loc3);
            _aEffects.splice(_loc2, _loc2 + 1);
        } // end while
    } // End of the function
    function nextTurn()
    {
        var _loc3 = _aEffects.length;
        var _loc2;
        while (--_loc3 >= 0)
        {
            _loc2 = _aEffects[_loc3];
            --_loc2.remainingTurn;
            if (_loc2.remainingTurn <= 0)
            {
                this.onEffectEnd(_loc2);
                _aEffects.splice(_loc3, 1);
            } // end if
        } // end while
    } // End of the function
    function onEffectStart(oEffect)
    {
        var _loc2 = oEffect.characteristic;
        switch (_loc2)
        {
            case dofus.managers.CharacteristicsManager.GFX:
            {
                _oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + oEffect.param2 + ".swf";
                _oSprite.mc.draw();
                break;
            } 
            case dofus.managers.CharacteristicsManager.INVISIBILITY:
            {
                if (_oSprite.id == api.datacenter.Player.ID)
                {
                    _oSprite.mc.setAlpha(40);
                }
                else
                {
                    _oSprite.mc.setVisible(false);
                } // end else if
                break;
            } 
            default:
            {
                if (_aModerators[_loc2] == undefined)
                {
                    _aModerators[_loc2] = 0;
                } // end if
                _aModerators[_loc2] = _aModerators[_loc2] + Number(oEffect.getParamWithOperator(1));
                break;
            } 
        } // End of switch
    } // End of the function
    function onEffectEnd(oEffect)
    {
        switch (oEffect.characteristic)
        {
            case dofus.managers.CharacteristicsManager.GFX:
            {
                _oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + oEffect.param1 + ".swf";
                _oSprite.mc.draw();
                break;
            } 
            case dofus.managers.CharacteristicsManager.INVISIBILITY:
            {
                if (_oSprite.id == api.datacenter.Player.ID)
                {
                    _oSprite.mc.setAlpha(100);
                }
                else
                {
                    _oSprite.mc.setVisible(true);
                } // end else if
                break;
            } 
            default:
            {
                _aModerators[Number(oEffect.characteristic)] = _aModerators[Number(oEffect.characteristic)] - Number(oEffect.getParamWithOperator(1));
                break;
            } 
        } // End of switch
    } // End of the function
    static var LIFE_POINTS = 0;
    static var ACTION_POINTS = 1;
    static var GOLD = 2;
    static var STATS_POINTS = 3;
    static var SPELL_POINTS = 4;
    static var LEVEL = 5;
    static var STRENGTH = 10;
    static var VITALITY = 11;
    static var WISDOM = 12;
    static var CHANCE = 13;
    static var AGILITY = 14;
    static var INTELLIGENCE = 15;
    static var DAMAGES = 16;
    static var DAMAGES_FACTOR = 17;
    static var DAMAGES_PERCENT = 25;
    static var CRITICAL_HIT = 18;
    static var RANGE = 19;
    static var DAMAGES_MAGICAL_REDUCTION = 20;
    static var DAMAGES_PHYSICAL_REDUCTION = 21;
    static var EXPERIENCE_BOOST = 22;
    static var MOVEMENT_POINTS = 23;
    static var INVISIBILITY = 24;
    static var MAX_SUMMONED_CREATURES_BOOST = 26;
    static var DODGE_PA_LOST_PROBABILITY = 27;
    static var DODGE_PM_LOST_PROBABILITY = 28;
    static var ENERGY_POINTS = 29;
    static var ALIGNMENT = 30;
    static var WEAPON_DAMAGES_PERCENT = 31;
    static var PHYSICAL_DAMAGES = 32;
    static var EARTH_ELEMENT_PERCENT = 33;
    static var FIRE_ELEMENT_PERCENT = 34;
    static var WATER_ELEMENT_PERCENT = 35;
    static var AIR_ELEMENT_PERCENT = 36;
    static var NEUTRAL_ELEMENT_PERCENT = 37;
    static var GFX = 38;
    static var CRITICAL_MISS = 39;
} // End of Class
#endinitclip
