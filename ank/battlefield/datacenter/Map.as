// Action script...

// [Initial MovieClip Action of sprite 847]
#initclip 59
class ank.battlefield.datacenter.Map extends Object
{
    var id, originalsCellsBackup, data;
    function Map(nID)
    {
        super();
        this.initialize(nID);
    } // End of the function
    function initialize(nID)
    {
        id = nID;
        originalsCellsBackup = new ank.utils.ExtendedObject();
    } // End of the function
    function cleanSpritesOn()
    {
        if (data != undefined)
        {
            for (var _loc2 in data)
            {
                data[_loc2].removeAllSpritesOnID();
            } // end of for...in
        } // end if
    } // End of the function
} // End of Class
#endinitclip
