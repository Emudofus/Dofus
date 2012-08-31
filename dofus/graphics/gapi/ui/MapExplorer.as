// Action script...

// [Initial MovieClip Action of sprite 1035]
#initclip 1
class dofus.graphics.gapi.ui.MapExplorer extends ank.gapi.core.UIAdvancedComponent
{
    var _dmMap, __get__mapID, _sPointer, __get__pointer, _mnMap, gapi, unloadThis, addToQueue, _lblArea, api, _winBg, _lblZoom, _btnClose, _btnZoomPlus, _btnZoomMinous, _btnMove, _btnSelect, _vsZoom, _mcTriangleNW, _mcTriangleN, _mcTriangleNE, _mcTriangleW, _mcTriangleE, _mcTriangleSW, _mcTriangleS, _mcTriangleSE, setMovieClipTransform, _lblAreaName, __set__mapID, __set__pointer;
    function MapExplorer()
    {
        super();
    } // End of the function
    function set mapID(nMapID)
    {
        _dmMap = new dofus.datacenter.DofusMap(nMapID);
        //return (this.mapID());
        null;
    } // End of the function
    function set pointer(sPointer)
    {
        _sPointer = sPointer;
        //return (this.pointer());
        null;
    } // End of the function
    function multipleSelect(aCoords)
    {
        _mnMap.clear("highlight");
        for (var _loc4 in aCoords)
        {
            var _loc2 = aCoords[_loc4];
            if (_loc2 != undefined)
            {
                _mnMap.addXtraClip("UI_MapExplorerFlag", "highlight", _loc2.x, _loc2.y, 16711680);
            } // end if
        } // end of for...in
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.MapExplorer.CLASS_NAME);
        ank.utils.MouseEvents.addListener(this);
        gapi.removeCursor(true);
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
        gapi.removeCursor(true);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        _lblArea._visible = false;
    } // End of the function
    function initTexts()
    {
        _winBg.__set__title(api.lang.getText("WORLD_MAP"));
        _lblZoom.__set__text(api.lang.getText("ZOOM"));
        _lblArea.__set__text(api.lang.getText("AREA"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnZoomPlus.addEventListener("click", this);
        _btnZoomMinous.addEventListener("click", this);
        _btnMove.addEventListener("click", this);
        _btnSelect.addEventListener("click", this);
        _mnMap.addEventListener("overMap", this);
        _mnMap.addEventListener("outMap", this);
        _mnMap.addEventListener("over", this);
        _mnMap.addEventListener("out", this);
        _mnMap.addEventListener("zoom", this);
        _mnMap.addEventListener("select", this);
        _vsZoom.addEventListener("change", this);
    } // End of the function
    function initData()
    {
        if (_dmMap == undefined)
        {
            _dmMap = api.datacenter.Map;
        } // end if
        this.showMapSuperArea(_dmMap.__get__superarea());
    } // End of the function
    function showMapSuperArea(nSuperAreaID)
    {
        if (nSuperAreaID == undefined)
        {
            return;
        } // end if
        _mnMap.__set__contentPath(dofus.Constants.LOCAL_MAPS_PATH + nSuperAreaID + ".swf");
        _mnMap.clear();
        _mnMap.setMapPosition(_dmMap.__get__x(), _dmMap.__get__y());
        var _loc2 = api.datacenter.Map;
        _mnMap.addXtraClip("UI_MapExplorerSelectRectangle", "rectangle", _loc2.x, _loc2.y, dofus.Constants.MAP_CURRENT_POSITION, 50);
        if (_dmMap != _loc2)
        {
            _mnMap.addXtraClip("UI_MapExplorerSelectRectangle", "rectangle", _dmMap.__get__x(), _dmMap.__get__y(), dofus.Constants.MAP_WAYPOINT_POSITION, 50);
        } // end if
        if (api.datacenter.Basics.banner_targetCoords != undefined)
        {
            _mnMap.addXtraClip("UI_MapExplorerFlag", "flag", api.datacenter.Basics.banner_targetCoords[0], api.datacenter.Basics.banner_targetCoords[1], 255);
        } // end if
        if (api.datacenter.Basics.aks_infos_highlightCoords != undefined)
        {
            this.multipleSelect(api.datacenter.Basics.aks_infos_highlightCoords);
        } // end if
    } // End of the function
    function hideArrows(bHide)
    {
        _mcTriangleNW._visible = _mcTriangleN._visible = _mcTriangleNE._visible = _mcTriangleW._visible = _mcTriangleE._visible = _mcTriangleSW._visible = _mcTriangleS._visible = _mcTriangleSE._visible = !bHide;
    } // End of the function
    function onMouseWheel(nIncrement, mcTarget)
    {
        if (mcTarget._target.indexOf("_mnMap", 0) != -1)
        {
            _mnMap.zoomIndex = _mnMap.zoomIndex + (nIncrement < 0 ? (-1) : (1));
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnZoomPlus":
            {
                _mnMap.__set__interactionMode("zoom+");
                _btnZoomMinous.__set__selected(false);
                _btnMove.__set__selected(false);
                _btnSelect.__set__selected(false);
                _btnZoomPlus.__set__enabled(false);
                _btnZoomMinous.__set__enabled(true);
                _btnMove.__set__enabled(true);
                _btnSelect.__set__enabled(true);
                this.hideArrows(true);
                break;
            } 
            case "_btnZoomMinous":
            {
                _mnMap.__set__interactionMode("zoom-");
                _btnZoomPlus.__set__selected(false);
                _btnMove.__set__selected(false);
                _btnSelect.__set__selected(false);
                _btnZoomPlus.__set__enabled(true);
                _btnZoomMinous.__set__enabled(false);
                _btnMove.__set__enabled(true);
                _btnSelect.__set__enabled(true);
                this.hideArrows(true);
                break;
            } 
            case "_btnMove":
            {
                _mnMap.__set__interactionMode("move");
                _btnZoomMinous.__set__selected(false);
                _btnZoomPlus.__set__selected(false);
                _btnSelect.__set__selected(false);
                _btnZoomPlus.__set__enabled(true);
                _btnZoomMinous.__set__enabled(true);
                _btnMove.__set__enabled(false);
                _btnSelect.__set__enabled(true);
                this.hideArrows(false);
                break;
            } 
            case "_btnSelect":
            {
                _mnMap.__set__interactionMode("select");
                _btnZoomMinous.__set__selected(false);
                _btnZoomPlus.__set__selected(false);
                _btnMove.__set__selected(false);
                _btnZoomPlus.__set__enabled(true);
                _btnZoomMinous.__set__enabled(true);
                _btnMove.__set__enabled(true);
                _btnSelect.__set__enabled(false);
                this.hideArrows(true);
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = oEvent.target._name.substr(4);
        this.setMovieClipTransform(this["_mcTriangle" + _loc2], dofus.graphics.gapi.ui.MapExplorer.OVER_TRIANGLE_TRANSFORM);
    } // End of the function
    function out(oEvent)
    {
        for (var _loc2 = 0; _loc2 < dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS.length; ++_loc2)
        {
            this.setMovieClipTransform(this["_mcTriangle" + dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS[_loc2]], dofus.graphics.gapi.ui.MapExplorer.OUT_TRIANGLE_TRANSFORM);
        } // end of for
    } // End of the function
    function change(oEvent)
    {
        _mnMap.__set__zoomIndex(oEvent.target.value);
    } // End of the function
    function zoom(oEvent)
    {
        _vsZoom.__set__value(oEvent.target.zoomIndex);
    } // End of the function
    function select(oEvent)
    {
        var _loc2 = oEvent.coordinates;
        _mnMap.clear("flag");
        if (api.kernel.GameManager.updateCompass(_loc2.x, _loc2.y, false))
        {
            _mnMap.addXtraClip("UI_MapExplorerFlag", "flag", _loc2.x, _loc2.y, 255);
        } // end if
    } // End of the function
    function overMap(oEvent)
    {
        var _loc2 = api.kernel.AreasManager.getAreaIDFromCoordinates(oEvent.coordinates.x, oEvent.coordinates.y);
        if (_loc2 != undefined)
        {
            var _loc3 = (dofus.datacenter.Area)(api.datacenter.Areas.getItemAt(_loc2));
            var _loc4;
            var _loc5;
            if (_loc3 != undefined)
            {
                _loc4 = _loc3.color;
                _loc5 = _loc3.__get__name() + " (" + _loc3.alignment.name + ")";
            }
            else
            {
                _loc4 = dofus.Constants.AREA_NO_ALIGNMENT_COLOR;
                _loc5 = api.lang.getMapAreaText(_loc2).n;
            } // end else if
            if (_vsZoom.__get__value() != 2)
            {
                _mnMap.addAreaClip(_loc2, _loc4, 20);
            } // end if
            _lblAreaName.__set__text(_loc5);
            _lblArea._visible = true;
        }
        else
        {
            this.outMap();
        } // end else if
    } // End of the function
    function outMap(oEvent)
    {
        _mnMap.removeAreaClip();
        _lblAreaName.__set__text("");
        _lblArea._visible = false;
    } // End of the function
    static var CLASS_NAME = "MapExplorer";
    static var OVER_TRIANGLE_TRANSFORM = {ra: 0, rb: 255, ga: 0, gb: 102, ba: 0, bb: 0};
    static var OUT_TRIANGLE_TRANSFORM = {ra: 0, rb: 184, ga: 0, gb: 177, ba: 0, bb: 143};
    static var DIRECTIONS = new Array("NW", "N", "NE", "W", "E", "SW", "S", "SE");
} // End of Class
#endinitclip
