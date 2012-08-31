// Action script...

// [Initial MovieClip Action of sprite 882]
#initclip 94
class dofus.datacenter.Spell extends Object
{
    var _nID, _oSpellText, _nLevel, _nMaxLevel, __get__level, _nPosition, __get__position, _nAnimID, __get__animID, _bSummonSpell, _bInFrontOfSprite, __get__inFrontOfSprite, __get__rangeMin, api, __get__rangeMax, __get__effectsNormalHit, _aEffectZones, __get__ID, __set__animID, __get__apCost, __get__canBoostRange, __get__classID, __get__criticalFailure, __get__criticalHit, __get__delayBetweenLaunch, __get__description, __get__descriptionCriticalHit, __get__descriptionNormalHit, __get__effectZones, __get__effectsCriticalHit, __get__elements, __get__file, __get__freeCell, __get__glyphSpell, __get__iconFile, __set__inFrontOfSprite, __get__isValid, __get__launchCountByPlayerTurn, __get__launchCountByTurn, __set__level, __get__lineOfSight, __get__lineOnly, __get__maxLevel, __get__name, __set__position, __get__rangeStr, __get__summonSpell, __get__trapSpell;
    function Spell(nID, nLevel, sCompressedPosition)
    {
        super();
        this.initialize(nID, nLevel, sCompressedPosition);
    } // End of the function
    function get ID()
    {
        return (_nID);
    } // End of the function
    function get isValid()
    {
        return (_oSpellText["l" + _nLevel] != undefined);
    } // End of the function
    function get maxLevel()
    {
        return (_nMaxLevel);
    } // End of the function
    function set level(nLevel)
    {
        _nLevel = nLevel;
        //return (this.level());
        null;
    } // End of the function
    function get level()
    {
        return (_nLevel);
    } // End of the function
    function set position(nPosition)
    {
        _nPosition = nPosition;
        //return (this.position());
        null;
    } // End of the function
    function get position()
    {
        return (_nPosition);
    } // End of the function
    function set animID(nAnimID)
    {
        _nAnimID = nAnimID;
        //return (this.animID());
        null;
    } // End of the function
    function get animID()
    {
        return (_nAnimID);
    } // End of the function
    function get summonSpell()
    {
        return (_bSummonSpell);
    } // End of the function
    function get glyphSpell()
    {
        return (this.searchIfGlyph(this.getSpellLevelText(0)));
    } // End of the function
    function get trapSpell()
    {
        return (this.searchIfTrap(this.getSpellLevelText(0)));
    } // End of the function
    function set inFrontOfSprite(bInFrontOfSprite)
    {
        _bInFrontOfSprite = bInFrontOfSprite;
        //return (this.inFrontOfSprite());
        null;
    } // End of the function
    function get inFrontOfSprite()
    {
        return (_bInFrontOfSprite);
    } // End of the function
    function get iconFile()
    {
        return (dofus.Constants.SPELLS_ICONS_PATH + _nID + ".swf");
    } // End of the function
    function get file()
    {
        return (dofus.Constants.SPELLS_PATH + _nAnimID + ".swf");
    } // End of the function
    function get name()
    {
        return (_oSpellText.n);
    } // End of the function
    function get description()
    {
        return (_oSpellText.d);
    } // End of the function
    function get apCost()
    {
        return (this.getSpellLevelText(2));
    } // End of the function
    function get rangeMin()
    {
        return (this.getSpellLevelText(3));
    } // End of the function
    function get rangeMax()
    {
        return (this.getSpellLevelText(4));
    } // End of the function
    function get rangeStr()
    {
        //return ((this.rangeMin() != 0 ? (this.__get__rangeMin() + " " + api.lang.getText("TO") + " ") : ("")) + this.__get__rangeMax());
    } // End of the function
    function get criticalHit()
    {
        return (this.getSpellLevelText(5));
    } // End of the function
    function get criticalFailure()
    {
        return (this.getSpellLevelText(6));
    } // End of the function
    function get lineOnly()
    {
        return (this.getSpellLevelText(7));
    } // End of the function
    function get lineOfSight()
    {
        return (this.getSpellLevelText(8));
    } // End of the function
    function get freeCell()
    {
        return (this.getSpellLevelText(9));
    } // End of the function
    function get canBoostRange()
    {
        return (this.getSpellLevelText(10));
    } // End of the function
    function get classID()
    {
        return (this.getSpellLevelText(11));
    } // End of the function
    function get launchCountByTurn()
    {
        return (this.getSpellLevelText(12));
    } // End of the function
    function get launchCountByPlayerTurn()
    {
        return (this.getSpellLevelText(13));
    } // End of the function
    function get delayBetweenLaunch()
    {
        return (this.getSpellLevelText(14));
    } // End of the function
    function get descriptionNormalHit()
    {
        return (dofus.datacenter.Spell.getSpellDescriptionWithEffects(this.getSpellLevelText(0)));
    } // End of the function
    function get descriptionCriticalHit()
    {
        return (dofus.datacenter.Spell.getSpellDescriptionWithEffects(this.getSpellLevelText(1)));
    } // End of the function
    function get effectsNormalHit()
    {
        return (dofus.datacenter.Spell.getSpellEffects(this.getSpellLevelText(0)));
    } // End of the function
    function get effectsCriticalHit()
    {
        return (dofus.datacenter.Spell.getSpellEffects(this.getSpellLevelText(1)));
    } // End of the function
    function get elements()
    {
        var _loc2 = {none: false, neutral: false, earth: false, fire: false, water: false, air: false};
        var _loc4 = this.__get__effectsNormalHit();
        for (var _loc5 in _loc4)
        {
            var _loc3 = _loc4[_loc5].element;
            switch (_loc3)
            {
                case "N":
                {
                    _loc2.neutral = true;
                    break;
                } 
                case "E":
                {
                    _loc2.earth = true;
                    break;
                } 
                case "F":
                {
                    _loc2.fire = true;
                    break;
                } 
                case "W":
                {
                    _loc2.water = true;
                    break;
                } 
                case "A":
                {
                    _loc2.air = true;
                    break;
                } 
                default:
                {
                    _loc2.none = true;
                    break;
                } 
            } // End of switch
        } // end of for...in
        return (_loc2);
    } // End of the function
    function get effectZones()
    {
        return (_aEffectZones);
    } // End of the function
    function initialize(nID, nLevel, sCompressedPosition)
    {
        api = _global.API;
        _nID = nID;
        _nLevel = nLevel;
        _nPosition = ank.utils.Compressor.decode64(sCompressedPosition);
        if (_nPosition > 14 || _nPosition < 1)
        {
            _nPosition = null;
        } // end if
        _oSpellText = api.lang.getSpellText(nID);
        var _loc7 = this.getSpellLevelText(15);
        var _loc4 = _loc7.split("");
        _aEffectZones = new Array();
        for (var _loc3 = 0; _loc3 < _loc4.length; _loc3 = _loc3 + 2)
        {
            _aEffectZones.push({shape: _loc4[_loc3], size: ank.utils.Compressor.decode64(_loc4[_loc3 + 1])});
        } // end of for
        _bSummonSpell = this.searchIfSummon(this.getSpellLevelText(0)) || this.searchIfSummon(this.getSpellLevelText(1));
        _nMaxLevel = 1;
        for (var _loc3 = 1; _loc3 <= dofus.Constants.SPELL_BOOST_MAX_LEVEL; ++_loc3)
        {
            if (_oSpellText["l" + _loc3] == undefined)
            {
                break;
                continue;
            } // end if
            _nMaxLevel = _loc3;
        } // end of for
    } // End of the function
    function getSpellLevelText(nPropertyIndex)
    {
        return (_oSpellText["l" + _nLevel][nPropertyIndex]);
    } // End of the function
    function searchIfSummon(aEffects)
    {
        var _loc4 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
            {
                var _loc2 = aEffects[_loc1][0];
                if (_loc2 == 180 || _loc2 == 181)
                {
                    return (true);
                } // end if
            } // end of for
        } // end if
        return (false);
    } // End of the function
    function searchIfGlyph(aEffects)
    {
        var _loc4 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
            {
                var _loc2 = aEffects[_loc1][0];
                if (_loc2 == 401)
                {
                    return (true);
                } // end if
            } // end of for
        } // end if
        return (false);
    } // End of the function
    function searchIfTrap(aEffects)
    {
        var _loc4 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
            {
                var _loc2 = aEffects[_loc1][0];
                if (_loc2 == 400)
                {
                    return (true);
                } // end if
            } // end of for
        } // end if
        return (false);
    } // End of the function
    static function getSpellDescriptionWithEffects(aEffects, bVisibleOnly)
    {
        var _loc5 = new Array();
        var _loc7 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            for (var _loc3 = 0; _loc3 < _loc7; ++_loc3)
            {
                var _loc1 = aEffects[_loc3];
                var _loc4 = _loc1[0];
                var _loc2 = new dofus.datacenter.Effect(_loc4, _loc1[1], _loc1[2], _loc1[3], undefined, _loc1[4]);
                if (bVisibleOnly == true)
                {
                    if (_loc2.showInTooltip)
                    {
                        _loc5.push(_loc2.description);
                    } // end if
                    continue;
                } // end if
                _loc5.push(_loc2.description);
            } // end of for
            return (_loc5.join(", "));
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    static function getSpellEffects(aEffects)
    {
        var _loc4 = new Array();
        var _loc6 = aEffects.length;
        if (typeof(aEffects) == "object")
        {
            for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
            {
                var _loc1 = aEffects[_loc2];
                var _loc3 = _loc1[0];
                _loc4.push(new dofus.datacenter.Effect(_loc3, _loc1[1], _loc1[2], _loc1[3], undefined, _loc1[4]));
            } // end of for
            return (_loc4);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
