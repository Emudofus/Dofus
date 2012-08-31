// Action script...

// [Initial MovieClip Action of sprite 874]
#initclip 86
class dofus.datacenter.Monster extends dofus.datacenter.PlayableCharacter
{
    var initialize, _nNameID, __get__name, api, _nPowerLevel, __get__powerLevel, CharacteristicsManager, __get__Level, __get__alignment, __set__name, __set__powerLevel, __get__resistances;
    function Monster(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    } // End of the function
    function set name(nNameID)
    {
        _nNameID = Number(nNameID);
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (api.lang.getMonstersText(_nNameID).n);
    } // End of the function
    function set powerLevel(nPowerLevel)
    {
        _nPowerLevel = Number(nPowerLevel);
        //return (this.powerLevel());
        null;
    } // End of the function
    function get powerLevel()
    {
        return (_nPowerLevel);
    } // End of the function
    function get Level()
    {
        return (api.lang.getMonstersText(_nNameID)["g" + _nPowerLevel].l);
    } // End of the function
    function get resistances()
    {
        var _loc3 = api.lang.getMonstersText(_nNameID)["g" + _nPowerLevel].r;
        var _loc4 = new Array();
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            _loc4[_loc2] = _loc3[_loc2];
        } // end of for
        _loc4[5] = _loc4[5] + CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
        _loc4[6] = _loc4[6] + CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
        return (_loc4);
    } // End of the function
    function get alignment()
    {
        return (new dofus.datacenter.Alignment(api.lang.getMonstersText(_nNameID).a, 0));
    } // End of the function
    var _nSpeedModerator = 1.500000E+000;
} // End of Class
#endinitclip
