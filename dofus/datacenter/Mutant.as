// Action script...

// [Initial MovieClip Action of sprite 879]
#initclip 91
class dofus.datacenter.Mutant extends dofus.datacenter.Character
{
    var initialize, _nNameID, __get__name, api, _nPowerLevel, __get__powerLevel, __get__Level, __get__alignment, __set__name, __set__powerLevel, __get__resistances;
    function Mutant(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
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
    function get alignment()
    {
        return (new dofus.datacenter.Alignment());
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
        return (api.lang.getMonstersText(_nNameID)["g" + _nPowerLevel].r);
    } // End of the function
} // End of Class
#endinitclip
