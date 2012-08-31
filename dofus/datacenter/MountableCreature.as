// Action script...

// [Initial MovieClip Action of sprite 841]
#initclip 53
class dofus.datacenter.MountableCreature
{
    var _sGfxFile, _nGfxID, __get__gfxFile;
    function MountableCreature(sGfxFile, nGfxID)
    {
        this.initialize(sGfxFile, nGfxID);
    } // End of the function
    function get gfxFile()
    {
        return (_sGfxFile);
    } // End of the function
    function initialize(sGfxFile, nGfxID)
    {
        _sGfxFile = sGfxFile;
        _nGfxID = nGfxID;
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
} // End of Class
#endinitclip
