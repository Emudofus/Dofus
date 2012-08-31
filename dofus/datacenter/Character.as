// Action script...

// [Initial MovieClip Action of sprite 839]
#initclip 51
class dofus.datacenter.Character extends dofus.datacenter.PlayableCharacter
{
    var initialize, __get__isSlow, _nSpeedModerator, _nGuild, __get__Guild, _nSex, __get__Sex, _nAura, __get__Aura, _oAlignment, __get__alignment, _bMerchant, __get__Merchant, _nServerID, __get__serverID, _bDied, __get__Died, _sGuildName, __get__guildName, _oEmblem, __get__emblem, _nRestrictions, __get__restrictions, _aResistances, __get__resistances, CharacteristicsManager, __set__Aura, __set__Died, __set__Guild, __set__Merchant, __set__Sex, __set__alignment, __get__canBeAssault, __get__canBeAttack, __get__canBeChallenge, __get__canExchange, __get__canSwitchInCreaturesMode, __set__emblem, __get__forceWalk, __set__guildName, __set__resistances, __set__restrictions, __set__serverID, __get__speedModerator;
    function Character(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    } // End of the function
    function get speedModerator()
    {
        //return (this.isSlow() ? (5.000000E-001) : (_nSpeedModerator));
    } // End of the function
    function get Guild()
    {
        return (_nGuild);
    } // End of the function
    function set Guild(value)
    {
        _nGuild = Number(value);
        //return (this.Guild());
        null;
    } // End of the function
    function get Sex()
    {
        return (_nSex);
    } // End of the function
    function set Sex(value)
    {
        _nSex = Number(value);
        //return (this.Sex());
        null;
    } // End of the function
    function get Aura()
    {
        return (_nAura);
    } // End of the function
    function set Aura(value)
    {
        _nAura = Number(value);
        //return (this.Aura());
        null;
    } // End of the function
    function get alignment()
    {
        return (_oAlignment);
    } // End of the function
    function set alignment(value)
    {
        _oAlignment = value;
        //return (this.alignment());
        null;
    } // End of the function
    function get Merchant()
    {
        return (_bMerchant);
    } // End of the function
    function set Merchant(value)
    {
        _bMerchant = value;
        //return (this.Merchant());
        null;
    } // End of the function
    function get serverID()
    {
        return (_nServerID);
    } // End of the function
    function set serverID(value)
    {
        _nServerID = value;
        //return (this.serverID());
        null;
    } // End of the function
    function get Died()
    {
        return (_bDied);
    } // End of the function
    function set Died(value)
    {
        _bDied = value;
        //return (this.Died());
        null;
    } // End of the function
    function set guildName(sGuildName)
    {
        _sGuildName = sGuildName;
        //return (this.guildName());
        null;
    } // End of the function
    function get guildName()
    {
        return (_sGuildName);
    } // End of the function
    function set emblem(oEmblem)
    {
        _oEmblem = oEmblem;
        //return (this.emblem());
        null;
    } // End of the function
    function get emblem()
    {
        return (_oEmblem);
    } // End of the function
    function set restrictions(nRestrictions)
    {
        _nRestrictions = Number(nRestrictions);
        //return (this.restrictions());
        null;
    } // End of the function
    function get canBeAssault()
    {
        return ((_nRestrictions & 1) != 1);
    } // End of the function
    function get canBeChallenge()
    {
        return ((_nRestrictions & 2) != 2);
    } // End of the function
    function get canExchange()
    {
        return ((_nRestrictions & 4) != 4);
    } // End of the function
    function get canBeAttack()
    {
        return ((_nRestrictions & 8) != 8);
    } // End of the function
    function get forceWalk()
    {
        return ((_nRestrictions & 16) == 16);
    } // End of the function
    function get isSlow()
    {
        return ((_nRestrictions & 32) == 32);
    } // End of the function
    function get canSwitchInCreaturesMode()
    {
        return ((_nRestrictions & 64) != 64);
    } // End of the function
    function set resistances(aResistances)
    {
        _aResistances = aResistances;
        //return (this.resistances());
        null;
    } // End of the function
    function get resistances()
    {
        var _loc3 = new Array();
        for (var _loc2 = 0; _loc2 < _aResistances.length; ++_loc2)
        {
            _loc3[_loc2] = _aResistances[_loc2];
        } // end of for
        _loc3[5] = _loc3[5] + CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
        _loc3[6] = _loc3[6] + CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
        return (_loc3);
    } // End of the function
    var xtraClipTopAnimations = {staticF: true};
} // End of Class
#endinitclip
