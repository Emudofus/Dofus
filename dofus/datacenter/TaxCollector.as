// Action script...

// [Initial MovieClip Action of sprite 878]
#initclip 90
class dofus.datacenter.TaxCollector extends dofus.datacenter.PlayableCharacter
{
    var initialize, _sName, __get__name, _sGuildName, __get__guildName, _oEmblem, __get__emblem, __set__emblem, __set__guildName, __set__name, __get__resistances;
    function TaxCollector(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
    } // End of the function
    function set name(sName)
    {
        _sName = sName;
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        return (_sName);
    } // End of the function
    function get resistances()
    {
        return (new Array());
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
} // End of Class
#endinitclip
