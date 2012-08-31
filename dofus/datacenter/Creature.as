// Action script...

// [Initial MovieClip Action of sprite 873]
#initclip 85
class dofus.datacenter.Creature extends dofus.datacenter.PlayableCharacter
{
    var initialize, _nNameID, __get__name, api, _nPowerLevel, __get__powerLevel, CharacteristicsManager, __get__Level, __get__alignment, __set__name, __set__powerLevel, __get__resistances;
    function Creature(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
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
        var _loc2 = api.lang.getMonstersText(_nNameID)["g" + _nPowerLevel].r;
        _loc2[5] = _loc2[5] + CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
        _loc2[6] = _loc2[6] + CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
        return (_loc2);
    } // End of the function
    function get alignment()
    {
        return (new dofus.datacenter.Alignment(api.lang.getMonstersText(_nNameID).a, 0));
    } // End of the function
    var _sStartAnimation = "appear";
} // End of Class
#endinitclip
