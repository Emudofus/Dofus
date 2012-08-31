// Action script...

// [Initial MovieClip Action of sprite 961]
#initclip 173
class dofus.datacenter.Area extends Object
{
    var api, _nID, _oAlignment, __get__alignment, __set__alignment, __get__color, __get__id, __get__name;
    function Area(nID, nAlignment)
    {
        super();
        api = _global.API;
        this.initialize(nID, nAlignment);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get alignment()
    {
        return (_oAlignment);
    } // End of the function
    function set alignment(oAlignment)
    {
        _oAlignment = oAlignment;
        //return (this.alignment());
        null;
    } // End of the function
    function get name()
    {
        return (api.lang.getMapAreaText(String(_nID)).n);
    } // End of the function
    function get color()
    {
        return (dofus.Constants.AREA_ALIGNMENT_COLOR[_oAlignment.index]);
    } // End of the function
    function initialize(nID, nAlignment)
    {
        _nID = nID;
        _oAlignment = new dofus.datacenter.Alignment(nAlignment);
    } // End of the function
} // End of Class
#endinitclip
