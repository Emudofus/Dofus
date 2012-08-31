// Action script...

// [Initial MovieClip Action of sprite 666]
#initclip 2
class ank.gapi.controls.MapNavigator extends ank.gapi.core.UIBasicComponent
{
    var __get__buttonMargin, __get__initialized, __get__showGrid, _sURL, _ldrMap, __get__contentPath, __get__wPage, __get__hPage, __get__zoomPortionsSize, __get__zoomLevels, __get__zoomIndex, __get__interactionMode, _mcXtra, __get__virtualWPage, __get__virtualHPage, _nMapWidth, _nMapHeight, _nLastAreaID, attachMovie, createEmptyMovieClip, _mcMap, _mcMask, _mcGrid, _btnNW, _btnN, _btnNE, _btnW, _btnE, _btnSW, _btnS, _btnSE, _btnLocateClick, __width, __height, _mcBorder, _mcMapBorder, _mcMapBackground, getStyle, setMovieClipColor, drawRoundRect, dispatchEvent, _oLastCoordsOver, _nXRefPress, _nYRefPress, gapi, _sLastMapEvent, __set__buttonMargin, __set__contentPath, __set__hPage, __set__interactionMode, __set__showGrid, __set__wPage, __set__zoomIndex, __set__zoomLevels, __set__zoomPortionsSize;
    function MapNavigator()
    {
        super();
    } // End of the function
    function set buttonMargin(nButtonMargin)
    {
        _nButtonMargin = Number(nButtonMargin);
        //return (this.buttonMargin());
        null;
    } // End of the function
    function get buttonMargin()
    {
        return (_nButtonMargin);
    } // End of the function
    function set showGrid(bShowGrid)
    {
        _bShowGrid = bShowGrid;
        if (this.__get__initialized())
        {
            this.drawGrid();
        } // end if
        //return (this.showGrid());
        null;
    } // End of the function
    function get showGrid()
    {
        return (_bShowGrid);
    } // End of the function
    function set contentPath(sURL)
    {
        _sURL = sURL;
        if (this.__get__initialized())
        {
            _ldrMap.__set__contentPath(_sURL);
        } // end if
        //return (this.contentPath());
        null;
    } // End of the function
    function get contentPath()
    {
        return (_sURL);
    } // End of the function
    function set wPage(nXPage)
    {
        _nWPage = nXPage;
        //return (this.wPage());
        null;
    } // End of the function
    function get wPage()
    {
        return (_nWPage);
    } // End of the function
    function set hPage(nYPage)
    {
        _nHPage = nYPage;
        //return (this.hPage());
        null;
    } // End of the function
    function get hPage()
    {
        return (_nHPage);
    } // End of the function
    function set zoomPortionsSize(aZoomPortionsSize)
    {
        _aZoomPortionsSize = aZoomPortionsSize;
        //return (this.zoomPortionsSize());
        null;
    } // End of the function
    function get zoomPortionsSize()
    {
        return (_aZoomPortionsSize);
    } // End of the function
    function set zoomLevels(aZoomLevels)
    {
        _aZoomLevels = aZoomLevels;
        //return (this.zoomLevels());
        null;
    } // End of the function
    function get zoomLevels()
    {
        return (_aZoomLevels);
    } // End of the function
    function set zoomIndex(nZoomIndex)
    {
        if (isNaN(nZoomIndex))
        {
            return;
        } // end if
        if (nZoomIndex > _aZoomLevels.length - 1)
        {
            nZoomIndex = _aZoomLevels.length - 1;
        } // end if
        if (nZoomIndex < 0)
        {
            nZoomIndex = 0;
        } // end if
        _nZoomIndex = nZoomIndex;
        if (this.__get__initialized())
        {
            this.setZoom();
        } // end if
        //return (this.zoomIndex());
        null;
    } // End of the function
    function get zoomIndex()
    {
        return (_nZoomIndex);
    } // End of the function
    function set interactionMode(sInteractionMode)
    {
        _sInteractionMode = sInteractionMode;
        if (this.__get__initialized())
        {
            this.applyInteractionMode();
        } // end if
        //return (this.interactionMode());
        null;
    } // End of the function
    function get interactionMode()
    {
        return (_sInteractionMode);
    } // End of the function
    function get virtualWPage()
    {
        return (_nWPage * _aZoomLevels[_nZoomIndex] / 100);
    } // End of the function
    function get virtualHPage()
    {
        return (_nHPage * _aZoomLevels[_nZoomIndex] / 100);
    } // End of the function
    function setMapPosition(nX, nY)
    {
        this.removeAreaClip();
        _nXCurrent = nX;
        _nYCurrent = nY;
        var _loc13 = _ldrMap.__get__content();
        _loc13._x = _mcXtra._x = -this.__get__virtualWPage() * (5.000000E-001 + nX);
        _loc13._y = _mcXtra._y = -this.__get__virtualHPage() * (5.000000E-001 + nY);
        var _loc14 = _aZoomPortionsSize[_nZoomIndex].split("|");
        var _loc6 = _loc14[0];
        var _loc7 = _loc14[1];
        var _loc18 = Math.floor(nX - _nMapWidth / (2 * this.__get__virtualWPage()) + 5.000000E-001);
        var _loc17 = Math.floor(nY - _nMapHeight / (2 * this.__get__virtualHPage()) + 5.000000E-001);
        var _loc10 = Math.floor(_loc18 / _loc6);
        var _loc8 = Math.floor(_loc17 / _loc7);
        var _loc11 = _loc10 + Math.ceil(Math.floor(_nMapWidth / this.__get__virtualWPage()) / _loc6);
        var _loc9 = _loc8 + Math.ceil(Math.floor(_nMapHeight / this.__get__virtualHPage()) / _loc7);
        for (var _loc12 in _ldrMap.__get__content())
        {
            _ldrMap.content[_loc12].removeMovieClip();
        } // end of for...in
        for (var _loc3 = _loc10; _loc3 <= _loc11; ++_loc3)
        {
            for (var _loc2 = _loc8; _loc2 <= _loc9; ++_loc2)
            {
                _ldrMap.content.attachMovie(_nZoomIndex + "_" + _loc3 + "_" + _loc2, _loc3 + "_" + _loc2, _ldrMap.content.getNextHighestDepth(), {_x: _loc3 * _loc6 * this.__get__virtualWPage(), _y: _loc2 * _loc7 * this.__get__virtualHPage()});
            } // end of for
        } // end of for
    } // End of the function
    function addAreaClip(nAreaID, nColor, nAlpha)
    {
        if (nAreaID == _nLastAreaID)
        {
            return;
        } // end if
        this.removeAreaClip();
        var _loc2 = _ldrMap.content.attachMovie("area_" + nAreaID, "_mcArea", _ldrMap.content.getNextHighestDepth());
        var _loc3 = new Color(_loc2);
        _loc3.setRGB(nColor);
        _loc2._alpha = nAlpha;
        _loc2._xscale = _loc2._yscale = _aZoomLevels[_nZoomIndex];
        _nLastAreaID = nAreaID;
    } // End of the function
    function removeAreaClip()
    {
        _ldrMap.content._mcArea.removeMovieClip();
        delete this._nLastAreaID;
    } // End of the function
    function addXtraClip(sLink, sLayer, nX, nY, nColor, nAlpha)
    {
        var _loc6 = _nWPage * (5.000000E-001 + nX);
        var _loc7 = _nHPage * (5.000000E-001 + nY);
        var _loc2 = _mcXtra.getNextHighestDepth();
        var _loc3 = _mcXtra[sLayer];
        if (_loc3 == undefined)
        {
            _loc3 = _mcXtra.createEmptyMovieClip(sLayer, _loc2);
        } // end if
        _loc2 = _loc3.getNextHighestDepth();
        var _loc4 = _loc3.attachMovie(sLink, "clip" + _loc2, _loc2, {_x: _loc6, _y: _loc7});
        if (nColor != undefined)
        {
            var _loc5 = new Color(_loc4._mcColor);
            _loc5.setRGB(nColor);
        } // end if
        _loc4._alpha = nAlpha == undefined ? (100) : (nAlpha);
    } // End of the function
    function clear(sLayer)
    {
        if (sLayer != undefined)
        {
            _mcXtra[sLayer].removeMovieClip();
        }
        else
        {
            for (var _loc2 in _mcXtra)
            {
                _mcXtra[_loc2].removeMovieClip();
            } // end of for...in
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.MapNavigator.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        var _loc2 = {styleName: "none", backgroundDown: "ButtonSimpleRectangleUpDown", backgroundUp: "ButtonSimpleRectangleUpDown"};
        this.attachMovie("Rectangle", "_mcBorder", 0);
        this.attachMovie("Button", "_btnNW", 10, _loc2);
        this.attachMovie("Button", "_btnN", 20, _loc2);
        this.attachMovie("Button", "_btnNE", 30, _loc2);
        this.attachMovie("Button", "_btnW", 40, _loc2);
        this.attachMovie("Button", "_btnE", 50, _loc2);
        this.attachMovie("Button", "_btnSW", 60, _loc2);
        this.attachMovie("Button", "_btnS", 70, _loc2);
        this.attachMovie("Button", "_btnSE", 80, _loc2);
        this.attachMovie("Button", "_btnLocateClick", 90, _loc2);
        this.attachMovie("Rectangle", "_mcMapBorder", 100);
        this.attachMovie("Rectangle", "_mcMapBackground", 110);
        this.createEmptyMovieClip("_mcMap", 120);
        _ldrMap = (ank.gapi.controls.Loader)(_mcMap.attachMovie("Loader", "_ldrMap", 10, {centerContent: false, scaleContent: false, autoLoad: true, contentPath: _sURL}));
        this.attachMovie("Rectangle", "_mcMask", 130);
        _mcMap.setMask(_mcMask);
        _mcMap.createEmptyMovieClip("_mcGrid", 140);
        _mcGrid = _mcMap._mcGrid;
        _mcMap.createEmptyMovieClip("_mcXtra", 200);
        _mcXtra = _mcMap._mcXtra;
        _ldrMap.addEventListener("initialization", this);
        _btnNW.addEventListener("click", this);
        _btnN.addEventListener("click", this);
        _btnNE.addEventListener("click", this);
        _btnW.addEventListener("click", this);
        _btnE.addEventListener("click", this);
        _btnSW.addEventListener("click", this);
        _btnS.addEventListener("click", this);
        _btnSE.addEventListener("click", this);
        _btnLocateClick.addEventListener("click", this);
        _btnNW.addEventListener("over", this);
        _btnN.addEventListener("over", this);
        _btnNE.addEventListener("over", this);
        _btnW.addEventListener("over", this);
        _btnE.addEventListener("over", this);
        _btnSW.addEventListener("over", this);
        _btnS.addEventListener("over", this);
        _btnSE.addEventListener("over", this);
        _btnNW.addEventListener("out", this);
        _btnN.addEventListener("out", this);
        _btnNE.addEventListener("out", this);
        _btnW.addEventListener("out", this);
        _btnE.addEventListener("out", this);
        _btnSW.addEventListener("out", this);
        _btnS.addEventListener("out", this);
        _btnSE.addEventListener("out", this);
        this.applyInteractionMode();
    } // End of the function
    function arrange()
    {
        var _loc6 = __width - 2;
        var _loc7 = __height - 2;
        var _loc2 = _loc6 / 3;
        var _loc3 = _loc7 / 3;
        var _loc5 = _loc6 - _nButtonMargin * 2 - 2;
        var _loc4 = _loc7 - _nButtonMargin * 2 - 2;
        _mcBorder._width = __width;
        _mcBorder._height = __height;
        _btnNW.setSize(_loc2, _loc3);
        _btnN.setSize(_loc2 - 2, _loc3);
        _btnNE.setSize(_loc2, _loc3);
        _btnW.setSize(_loc2, _loc3 - 2);
        _btnE.setSize(_loc2, _loc3 - 2);
        _btnSW.setSize(_loc2, _loc3);
        _btnS.setSize(_loc2 - 2, _loc3);
        _btnSE.setSize(_loc2, _loc3);
        _btnNW._x = _btnW._x = _btnSW._x = 1;
        _btnN._x = _btnS._x = _loc2 + 2;
        _btnNE._x = _btnE._x = _btnSE._x = _loc2 * 2 + 1;
        _btnNW._y = _btnN._y = _btnNE._y = 1;
        _btnW._y = _btnE._y = _loc3 + 2;
        _btnSW._y = _btnS._y = _btnSE._y = _loc3 * 2 + 1;
        _mcMapBorder._width = _loc5 + 2;
        _mcMapBorder._height = _loc4 + 2;
        _mcMapBorder._x = _mcMapBorder._y = _nButtonMargin + 1;
        _mcMask._width = _mcMapBackground._width = _loc5;
        _mcMask._height = _mcMapBackground._height = _loc4;
        _btnLocateClick._x = _btnLocateClick._y = _mcMask._x = _mcMask._y = _mcMapBackground._x = _mcMapBackground._y = _nButtonMargin + 2;
        _mcMap._x = __width / 2;
        _mcMap._y = __height / 2;
        _mcGrid._x = -__width / 2 + _nButtonMargin + 2;
        _mcGrid._y = -__height / 2 + _nButtonMargin + 2;
        _btnLocateClick.setSize(_loc5, _loc4);
        _nMapWidth = __width - _nButtonMargin * 2 - 4;
        _nMapHeight = __height - _nButtonMargin * 2 - 4;
        this.setZoom();
        this.drawGrid();
        this.setMapPosition(0, 0);
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _btnNW.__set__styleName(_btnN.__set__styleName(_btnNE.__set__styleName(_btnW.__set__styleName(_btnE.__set__styleName(_btnSW.__set__styleName(_btnS.__set__styleName(_btnSE.__set__styleName(_loc2.buttonstyle))))))));
        this.setMovieClipColor(_mcBorder, _loc2.bordercolor);
        this.setMovieClipColor(_mcMapBorder, _loc2.bordercolor);
        this.setMovieClipColor(_mcGrid, _loc2.gridcolor);
        this.setMovieClipColor(_mcMapBackground, _loc2.bgcolor);
    } // End of the function
    function drawGrid(bZoomAccept)
    {
        if (bZoomAccept == undefined)
        {
            bZoomAccept = true;
        } // end if
        _mcGrid.clear();
        if (_bShowGrid && bZoomAccept)
        {
            var _loc3;
            var _loc2;
            for (var _loc3 = (_nMapWidth - this.__get__virtualWPage()) / 2; _loc3 > 0; _loc3 = _loc3 - virtualWPage)
            {
                this.drawRoundRect(_mcGrid, _loc3, 0, 1, _nMapHeight, 0, 0);
            } // end of for
            for (var _loc3 = (_nMapWidth + this.__get__virtualWPage()) / 2; _loc3 < _nMapWidth; _loc3 = _loc3 + virtualWPage)
            {
                this.drawRoundRect(_mcGrid, _loc3, 0, 1, _nMapHeight, 0, 0);
            } // end of for
            for (var _loc2 = (_nMapHeight - this.__get__virtualHPage()) / 2; _loc2 > 0; _loc2 = _loc2 - virtualHPage)
            {
                this.drawRoundRect(_mcGrid, 0, _loc2, _nMapWidth, 1, 0, 0);
            } // end of for
            for (var _loc2 = (_nMapHeight + this.__get__virtualHPage()) / 2; _loc2 < _nMapHeight; _loc2 = _loc2 + virtualHPage)
            {
                this.drawRoundRect(_mcGrid, 0, _loc2, _nMapWidth, 1, 0, 0);
            } // end of for
        } // end if
    } // End of the function
    function setZoom()
    {
        var _loc2 = _aZoomLevels[_nZoomIndex];
        if (_loc2 == undefined)
        {
            return;
        } // end if
        _mcXtra._xscale = _mcXtra._yscale = _loc2;
        this.setMapPosition(_nXCurrent, _nYCurrent);
        this.drawGrid(_loc2 > 30);
        this.dispatchEvent({type: "zoom"});
    } // End of the function
    function moveMap(nXWay, nYWay)
    {
        this.setMapPosition(_nXCurrent + nXWay, _nYCurrent + nYWay);
    } // End of the function
    function applyInteractionMode()
    {
        delete this._oLastCoordsOver;
        switch (_sInteractionMode)
        {
            case "move":
            {
                _btnNW.__set__enabled(true);
                _btnN.__set__enabled(true);
                _btnNE.__set__enabled(true);
                _btnW.__set__enabled(true);
                _btnE.__set__enabled(true);
                _btnSW.__set__enabled(true);
                _btnS.__set__enabled(true);
                _btnSE.__set__enabled(true);
                break;
            } 
            case "zoom+":
            case "zoom-":
            case "select":
            {
                _btnNW.__set__enabled(false);
                _btnN.__set__enabled(false);
                _btnNE.__set__enabled(false);
                _btnW.__set__enabled(false);
                _btnE.__set__enabled(false);
                _btnSW.__set__enabled(false);
                _btnS.__set__enabled(false);
                _btnSE.__set__enabled(false);
                break;
            } 
        } // End of switch
    } // End of the function
    function getRealFromCoordinates(nX, nY)
    {
        var _loc3 = this.__get__virtualWPage() * (nX - _nXCurrent - 5.000000E-001);
        var _loc2 = this.__get__virtualHPage() * (nY - _nYCurrent - 5.000000E-001);
        return ({x: _loc3, y: _loc2});
    } // End of the function
    function getCoordinatesFromReal(nRealX, nRealY)
    {
        var _loc3 = Math.floor((nRealX + this.__get__virtualWPage() * 5.000000E-001) / this.__get__virtualWPage()) + _nXCurrent;
        var _loc2 = Math.floor((nRealY + this.__get__virtualHPage() * 5.000000E-001) / this.__get__virtualHPage()) + _nYCurrent;
        return ({x: _loc3, y: _loc2});
    } // End of the function
    function getCoordinatesFromRealWithRef(nRealX, nRealY)
    {
        var _loc3 = Math.floor((nRealX + this.__get__virtualWPage() * 5.000000E-001) / this.__get__virtualWPage()) - _nXRefPress;
        var _loc2 = Math.floor((nRealY + this.__get__virtualHPage() * 5.000000E-001) / this.__get__virtualHPage()) - _nYRefPress;
        return ({x: _loc3, y: _loc2});
    } // End of the function
    function onMouseDown()
    {
        if (_sInteractionMode == "move")
        {
            if (_mcMapBackground.hitTest(_root._xmouse, _root._ymouse, true))
            {
                delete this._oLastCoordsOver;
                var _loc3 = this.getCoordinatesFromReal(_ldrMap._xmouse, _ldrMap._ymouse);
                _nXRefPress = _loc3.x;
                _nYRefPress = _loc3.y;
                gapi.hideTooltip();
                gapi.setCursor({iconFile: "MapNavigatorMoveCursor"});
            } // end if
        } // end if
    } // End of the function
    function onMouseUp()
    {
        delete this._nXRefPress;
        delete this._nYRefPress;
        gapi.removeCursor();
    } // End of the function
    function onMouseMove()
    {
        if (_mcMapBackground.hitTest(_root._xmouse, _root._ymouse, true))
        {
            var _loc7 = _ldrMap._xmouse;
            var _loc6 = _ldrMap._ymouse;
            if (_nXRefPress == undefined)
            {
                var _loc3 = this.getCoordinatesFromReal(_loc7, _loc6);
                if (_oLastCoordsOver.x != _loc3.x || _oLastCoordsOver.y != _loc3.y)
                {
                    var _loc4 = this.getRealFromCoordinates(_loc3.x, _loc3.y);
                    _ldrMap.localToGlobal(_loc4);
                    gapi.showTooltip(_loc3.x + ", " + _loc3.y, _loc4.x, _loc4.y - 20);
                    this.dispatchEvent({type: "overMap", coordinates: _loc3});
                    _sLastMapEvent = "overMap";
                    _oLastCoordsOver = _loc3;
                } // end if
            }
            else
            {
                var _loc5 = this.getCoordinatesFromRealWithRef(_loc7, _loc6);
                this.setMapPosition(-_loc5.x, -_loc5.y);
            } // end else if
        }
        else
        {
            if (_sLastMapEvent != "outMap")
            {
                this.dispatchEvent({type: "outMap"});
                _sLastMapEvent = "outMap";
            } // end if
            gapi.hideTooltip();
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnNW":
            {
                this.moveMap(-1, -1);
                break;
            } 
            case "_btnN":
            {
                this.moveMap(0, -1);
                break;
            } 
            case "_btnNE":
            {
                this.moveMap(1, -1);
                break;
            } 
            case "_btnW":
            {
                this.moveMap(-1, 0);
                break;
            } 
            case "_btnE":
            {
                this.moveMap(1, 0);
                break;
            } 
            case "_btnSW":
            {
                this.moveMap(-1, 1);
                break;
            } 
            case "_btnS":
            {
                this.moveMap(0, 1);
                break;
            } 
            case "_btnSE":
            {
                this.moveMap(1, 1);
                break;
            } 
            case "_btnLocateClick":
            {
                var _loc4 = _ldrMap._xmouse;
                var _loc3 = _ldrMap._ymouse;
                var _loc2 = this.getCoordinatesFromReal(_loc4, _loc3);
                switch (_sInteractionMode)
                {
                    case "zoom+":
                    case "zoom-":
                    {
                        this.setMapPosition(_loc2.x, _loc2.y);
                        zoomIndex = zoomIndex + (_sInteractionMode == "zoom+" ? (1) : (-1));
                        break;
                    } 
                    case "select":
                    {
                        this.dispatchEvent({type: "select", coordinates: _loc2});
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
        gapi.hideTooltip();
    } // End of the function
    function over(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    function out(oEvent)
    {
        this.dispatchEvent(oEvent);
    } // End of the function
    function initialization(oEvent)
    {
        this.setZoom();
    } // End of the function
    static var CLASS_NAME = "MapNavigator";
    var _nButtonMargin = 5;
    var _bShowGrid = true;
    var _aZoomLevels = [10, 50, 100];
    var _aZoomPortionsSize = [[120, 120], [25, 25], [15, 15]];
    var _nZoomIndex = 1;
    var _nWPage = 10;
    var _nHPage = 10;
    var _sInteractionMode = "move";
    var _nXCurrent = 0;
    var _nYCurrent = 0;
} // End of Class
#endinitclip
