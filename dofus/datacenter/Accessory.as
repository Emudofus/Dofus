// Action script...

// [Initial MovieClip Action of sprite 883]
#initclip 95
class dofus.datacenter.Accessory extends Object
{
    var api, _nUnicID, _oItemText, __get__type, __get__gfxID, __get__gfx, __get__unicID;
    function Accessory(nUnicID)
    {
        super();
        api = _global.API;
        this.initialize(nUnicID);
    } // End of the function
    function get unicID()
    {
        return (_nUnicID);
    } // End of the function
    function get type()
    {
        return (_oItemText.t);
    } // End of the function
    function get gfxID()
    {
        return (_oItemText.g);
    } // End of the function
    function get gfx()
    {
        //return (this.type() + "_" + this.__get__gfxID());
    } // End of the function
    function initialize(nUnicID)
    {
        _nUnicID = nUnicID;
        _oItemText = api.lang.getItemUnicText(nUnicID);
    } // End of the function
} // End of Class
#endinitclip
