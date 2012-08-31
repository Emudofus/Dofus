// Action script...

// [Initial MovieClip Action of sprite 877]
#initclip 89
class dofus.datacenter.OfflineCharacter extends ank.battlefield.datacenter.Sprite
{
    var __proto__, _sName, __get__name, _gfxID, __get__gfxID, _sGuildName, __get__guildName, _oEmblem, __get__emblem, _sOfflineType, __get__offlineType, __set__emblem, __set__gfxID, __set__guildName, __set__name, __set__offlineType;
    function OfflineCharacter(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        if (__proto__ == dofus.datacenter.OfflineCharacter.prototype)
        {
            this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
        } // end if
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
    function get gfxID()
    {
        return (_gfxID);
    } // End of the function
    function set gfxID(value)
    {
        _gfxID = value;
        //return (this.gfxID());
        null;
    } // End of the function
    function initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super.initialize(sID, clipClass, sGfxFile, cellNum, dir);
        _gfxID = gfxID;
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
    function set offlineType(sOfflineType)
    {
        _sOfflineType = sOfflineType;
        //return (this.offlineType());
        null;
    } // End of the function
    function get offlineType()
    {
        return (_sOfflineType);
    } // End of the function
    var xtraClipTopAnimations = {staticL: true, staticF: true, staticR: true};
} // End of Class
#endinitclip
