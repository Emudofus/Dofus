// Action script...

// [Initial MovieClip Action of sprite 887]
#initclip 99
class dofus.datacenter.DofusMap extends ank.battlefield.datacenter.Map
{
    var id, __get__subarea, __get__area, __get__coordinates, __get__musics, __get__superarea, __get__x, __get__y;
    function DofusMap(nID)
    {
        super(nID);
    } // End of the function
    function get coordinates()
    {
        var _loc3 = _global.API.lang.getMapText(id);
        return (_global.API.lang.getText("COORDINATES") + " : " + _loc3.x + ", " + _loc3.y);
    } // End of the function
    function get x()
    {
        return (_global.API.lang.getMapText(id).x);
    } // End of the function
    function get y()
    {
        return (_global.API.lang.getMapText(id).y);
    } // End of the function
    function get superarea()
    {
        var _loc3 = _global.API.lang;
        //return (_loc3.getMapAreaInfos(this.subarea()).superareaID);
    } // End of the function
    function get area()
    {
        var _loc3 = _global.API.lang;
        //return (_loc3.getMapAreaInfos(this.subarea()).areaID);
    } // End of the function
    function get subarea()
    {
        var _loc3 = _global.API.lang;
        return (_loc3.getMapText(id).sa);
    } // End of the function
    function get musics()
    {
        var _loc3 = _global.API.lang;
        //return (_loc3.getMapSubAreaText(this.subarea()).m);
    } // End of the function
} // End of Class
#endinitclip
