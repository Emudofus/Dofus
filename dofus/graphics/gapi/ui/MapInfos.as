// Action script...

// [Initial MovieClip Action of sprite 1031]
#initclip 252
class dofus.graphics.gapi.ui.MapInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _visible, addToQueue, api, _lblArea, _lblCoordinates, _lblAreaShadow, _lblCoordinatesShadow;
    function MapInfos()
    {
        super();
    } // End of the function
    function update()
    {
        this.initText();
        _visible = true;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.MapInfos.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initText});
    } // End of the function
    function initText()
    {
        var _loc2 = api.datacenter.Map;
        if (_loc2.name == undefined)
        {
            _lblArea.__set__text("");
            _lblCoordinates.__set__text("");
            _lblAreaShadow.__set__text("");
            _lblCoordinatesShadow.__set__text("");
        }
        else
        {
            var _loc3 = api.datacenter.Areas.getItemAt(_loc2.area);
            var _loc4 = _loc2.name + (_loc3 == undefined ? ("") : (_loc3.alignment.name == undefined ? ("") : (" - " + _loc3.alignment.name)));
            _lblArea.__set__text(_loc4);
            _lblCoordinates.__set__text(_loc2.coordinates);
            _lblAreaShadow.__set__text(_loc4);
            _lblCoordinatesShadow.__set__text(_loc2.coordinates);
        } // end else if
    } // End of the function
    static var CLASS_NAME = "MapInfos";
} // End of Class
#endinitclip
