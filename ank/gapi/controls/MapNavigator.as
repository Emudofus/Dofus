// Action script...

// [Initial MovieClip Action of sprite 20614]
#initclip 135
if (!ank.gapi.controls.MapNavigator)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.MapNavigator = function ()
    {
        super();
    }).prototype;
    _loc1.__set__buttonMargin = function (nButtonMargin)
    {
        this._nButtonMargin = Number(nButtonMargin);
        //return (this.buttonMargin());
    };
    _loc1.__get__buttonMargin = function ()
    {
        return (this._nButtonMargin);
    };
    _loc1.__set__showGrid = function (bShowGrid)
    {
        this._bShowGrid = bShowGrid;
        if (this.initialized)
        {
            this.drawGrid();
        } // end if
        //return (this.showGrid());
    };
    _loc1.__get__showGrid = function ()
    {
        return (this._bShowGrid);
    };
    _loc1.__set__contentPath = function (sURL)
    {
        this._sURL = sURL;
        if (this.initialized)
        {
            this._ldrMap.contentPath = this._sURL;
        } // end if
        //return (this.contentPath());
    };
    _loc1.__get__contentPath = function ()
    {
        return (this._sURL);
    };
    _loc1.__set__wPage = function (nXPage)
    {
        this._nWPage = nXPage;
        //return (this.wPage());
    };
    _loc1.__get__wPage = function ()
    {
        return (this._nWPage);
    };
    _loc1.__set__hPage = function (nYPage)
    {
        this._nHPage = nYPage;
        //return (this.hPage());
    };
    _loc1.__get__hPage = function ()
    {
        return (this._nHPage);
    };
    _loc1.__set__zoom = function (nZoom)
    {
        if (_global.isNaN(nZoom))
        {
            return;
        } // end if
        if (nZoom > 100)
        {
            nZoom = 100;
        } // end if
        if (nZoom < 10)
        {
            nZoom = 10;
        } // end if
        this._nZoom = nZoom;
        if (this.initialized)
        {
            this.setZoom();
        } // end if
        //return (this.zoom());
    };
    _loc1.__get__zoom = function ()
    {
        return (this._nZoom);
    };
    _loc1.__set__interactionMode = function (sInteractionMode)
    {
        this._sInteractionMode = sInteractionMode;
        if (this.initialized)
        {
            this.applyInteractionMode();
        } // end if
        //return (this.interactionMode());
    };
    _loc1.__get__interactionMode = function ()
    {
        return (this._sInteractionMode);
    };
    _loc1.__get__virtualWPage = function ()
    {
        return (this._nWPage * this._nZoom / 100);
    };
    _loc1.__get__virtualHPage = function ()
    {
        return (this._nHPage * this._nZoom / 100);
    };
    _loc1.__get__currentX = function ()
    {
        return (this._nXCurrent);
    };
    _loc1.__get__currentY = function ()
    {
        return (this._nYCurrent);
    };
    _loc1.__get__loaderMap = function ()
    {
        return (this._ldrMap);
    };
    _loc1.setMapPosition = function (nX, nY)
    {
        this._mcXtra._xscale = this._mcXtra._yscale = this._nZoom;
        if (nX == undefined || nY == undefined)
        {
            return;
        } // end if
        this.removeAreaClip();
        this._nXCurrent = nX;
        this._nYCurrent = nY;
        var _loc4 = this._ldrMap.content;
        _loc4._x = this._mcXtra._x = -this.virtualWPage * (5.000000E-001 + nX);
        _loc4._y = this._mcXtra._y = -this.virtualHPage * (5.000000E-001 + nY);
        var _loc5 = 15;
        var _loc6 = 15;
        var _loc7 = Math.floor(nX - this._nMapWidth / (2 * this.virtualWPage) + 5.000000E-001);
        var _loc8 = Math.floor(nY - this._nMapHeight / (2 * this.virtualHPage) + 5.000000E-001);
        var _loc9 = Math.floor(_loc7 / _loc5);
        var _loc10 = Math.floor(_loc8 / _loc6);
        var _loc11 = _loc9 + Math.ceil(Math.floor(this._nMapWidth / this.virtualWPage) / _loc5);
        var _loc12 = _loc10 + Math.ceil(Math.floor(this._nMapHeight / this.virtualHPage) / _loc6);
        for (var k in this._ldrMap.content)
        {
            this._ldrMap.content[k].removeMovieClip();
        } // end of for...in
        var _loc13 = _loc9;
        
        while (++_loc13, _loc13 <= _loc11)
        {
            var _loc14 = _loc10;
            
            while (++_loc14, _loc14 <= _loc12)
            {
                this._ldrMap.content.attachMovie(_loc13 + "_" + _loc14, _loc13 + "_" + _loc14, this._ldrMap.content.getNextHighestDepth(), {_yscale: this._nZoom, _xscale: this._nZoom, _x: _loc13 * _loc5 * this.virtualWPage, _y: _loc14 * _loc6 * this.virtualHPage});
            } // end while
        } // end while
    };
    _loc1.addSubareaClip = function (nSubAreaID, nColor, nAlpha)
    {
        if (nSubAreaID == this._nLastSubAreaID)
        {
            return;
        } // end if
        this.removeAreaClip();
        var _loc5 = this._ldrMap.content.attachMovie("subarea_" + nSubAreaID, "_mcSubarea", this._ldrMap.content.getNextHighestDepth());
        var _loc6 = new Color(_loc5);
        _loc6.setRGB(nColor);
        _loc5._alpha = nAlpha;
        _loc5._xscale = _loc5._yscale = this._nZoom;
        this._nLastSubAreaID = nSubAreaID;
    };
    _loc1.removeAreaClip = function ()
    {
        this._ldrMap.content._mcSubarea.removeMovieClip();
        delete this._nLastSubAreaID;
    };
    _loc1.addXtraClip = function (sLink, sLayer, nX, nY, nColor, nAlpha, bDispatchClickEvent, bDontAddIfXtra)
    {
        var _loc10 = this._mcXtra[sLayer]["clipByCoord_" + nX + "_" + nY];
        if (bDontAddIfXtra == true && _loc10 != undefined)
        {
            return (_loc10);
        } // end if
        var _loc11 = this._nWPage * (5.000000E-001 + nX);
        var _loc12 = this._nHPage * (5.000000E-001 + nY);
        var _loc13 = this._mcXtra.getNextHighestDepth();
        var _loc14 = this._mcXtra[sLayer];
        if (_loc14 == undefined)
        {
            _loc14 = this._mcXtra.createEmptyMovieClip(sLayer, _loc13);
        } // end if
        _loc13 = _loc14.getNextHighestDepth();
        var _loc15 = _loc14.attachMovie(sLink, "clip" + _loc13, _loc13, {_x: _loc11, _y: _loc12});
        this._mcXtra[sLayer]["clipByCoord_" + nX + "_" + nY] = _loc15;
        if (nColor != undefined)
        {
            var _loc16 = new Color(_loc15._mcColor);
            _loc16.setRGB(nColor);
        } // end if
        if (bDispatchClickEvent)
        {
            _loc15.mn = this;
            _loc15.onRelease = function ()
            {
                this.mn.click({target: this.mn._btnLocateClick});
            };
        } // end if
        _loc15._alpha = nAlpha == undefined ? (100) : (nAlpha);
        return (_loc15);
    };
    _loc1.loadXtraLayer = function (sFile, sLayer)
    {
        var _loc4 = this.createXtraLayer(sLayer);
        var _loc5 = new MovieClipLoader();
        _loc5.addListener(this);
        _loc5.loadClip(sFile, _loc4);
    };
    _loc1.createXtraLayer = function (sLayer)
    {
        var _loc3 = this._mcXtra.getNextHighestDepth();
        var _loc4 = this._mcXtra[sLayer];
        if (_loc4 == undefined)
        {
            _loc4 = this._mcXtra.createEmptyMovieClip(sLayer, _loc3);
        } // end if
        return (_loc4);
    };
    _loc1.getXtraLayer = function (sLayer)
    {
        return (this._mcXtra[sLayer]);
    };
    _loc1.clear = function (sLayer)
    {
        if (sLayer != undefined)
        {
            this._mcXtra[sLayer].removeMovieClip();
        }
        else
        {
            for (var k in this._mcXtra)
            {
                this._mcXtra[k].removeMovieClip();
            } // end of for...in
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.MapNavigator.CLASS_NAME);
    };
    _loc1.createChildren = function ()
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
        this._ldrMap = (ank.gapi.controls.Loader)(this._mcMap.attachMovie("Loader", "_ldrMap", 10, {centerContent: false, scaleContent: false, autoLoad: true, contentPath: this._sURL}));
        this.attachMovie("Rectangle", "_mcMask", 130);
        this._mcMap.setMask(this._mcMask);
        this._mcMap.createEmptyMovieClip("_mcGrid", 140);
        this._mcGrid = this._mcMap._mcGrid;
        this._mcMap.createEmptyMovieClip("_mcXtra", 200);
        this._mcXtra = this._mcMap._mcXtra;
        this._ldrMap.addEventListener("initialization", this);
        this._btnNW.addEventListener("click", this);
        this._btnN.addEventListener("click", this);
        this._btnNE.addEventListener("click", this);
        this._btnW.addEventListener("click", this);
        this._btnE.addEventListener("click", this);
        this._btnSW.addEventListener("click", this);
        this._btnS.addEventListener("click", this);
        this._btnSE.addEventListener("click", this);
        this._btnLocateClick.addEventListener("click", this);
        this._btnNW.addEventListener("over", this);
        this._btnN.addEventListener("over", this);
        this._btnNE.addEventListener("over", this);
        this._btnW.addEventListener("over", this);
        this._btnE.addEventListener("over", this);
        this._btnSW.addEventListener("over", this);
        this._btnS.addEventListener("over", this);
        this._btnSE.addEventListener("over", this);
        this._btnNW.addEventListener("out", this);
        this._btnN.addEventListener("out", this);
        this._btnNE.addEventListener("out", this);
        this._btnW.addEventListener("out", this);
        this._btnE.addEventListener("out", this);
        this._btnSW.addEventListener("out", this);
        this._btnS.addEventListener("out", this);
        this._btnSE.addEventListener("out", this);
        this.applyInteractionMode();
    };
    _loc1.arrange = function ()
    {
        var _loc2 = this.__width - 2;
        var _loc3 = this.__height - 2;
        var _loc4 = _loc2 / 3;
        var _loc5 = _loc3 / 3;
        var _loc6 = _loc2 - this._nButtonMargin * 2 - 2;
        var _loc7 = _loc3 - this._nButtonMargin * 2 - 2;
        this._mcBorder._width = this.__width;
        this._mcBorder._height = this.__height;
        this._btnNW.setSize(_loc4, _loc5);
        this._btnN.setSize(_loc4 - 2, _loc5);
        this._btnNE.setSize(_loc4, _loc5);
        this._btnW.setSize(_loc4, _loc5 - 2);
        this._btnE.setSize(_loc4, _loc5 - 2);
        this._btnSW.setSize(_loc4, _loc5);
        this._btnS.setSize(_loc4 - 2, _loc5);
        this._btnSE.setSize(_loc4, _loc5);
        this._btnNW._x = this._btnW._x = this._btnSW._x = 1;
        this._btnN._x = this._btnS._x = _loc4 + 2;
        this._btnNE._x = this._btnE._x = this._btnSE._x = _loc4 * 2 + 1;
        this._btnNW._y = this._btnN._y = this._btnNE._y = 1;
        this._btnW._y = this._btnE._y = _loc5 + 2;
        this._btnSW._y = this._btnS._y = this._btnSE._y = _loc5 * 2 + 1;
        this._mcMapBorder._width = _loc6 + 2;
        this._mcMapBorder._height = _loc7 + 2;
        this._mcMapBorder._x = this._mcMapBorder._y = this._nButtonMargin + 1;
        this._mcMask._width = this._mcMapBackground._width = _loc6;
        this._mcMask._height = this._mcMapBackground._height = _loc7;
        this._btnLocateClick._x = this._btnLocateClick._y = this._mcMask._x = this._mcMask._y = this._mcMapBackground._x = this._mcMapBackground._y = this._nButtonMargin + 2;
        this._mcMap._x = this.__width / 2;
        this._mcMap._y = this.__height / 2;
        this._mcGrid._x = -this.__width / 2 + this._nButtonMargin + 2;
        this._mcGrid._y = -this.__height / 2 + this._nButtonMargin + 2;
        this._btnLocateClick.setSize(_loc6, _loc7);
        this._nMapWidth = this.__width - this._nButtonMargin * 2 - 4;
        this._nMapHeight = this.__height - this._nButtonMargin * 2 - 4;
        this.setZoom();
        this.setMapPosition(0, 0);
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._btnNW.styleName = this._btnN.styleName = this._btnNE.styleName = this._btnW.styleName = this._btnE.styleName = this._btnSW.styleName = this._btnS.styleName = this._btnSE.styleName = _loc2.buttonstyle;
        this.setMovieClipColor(this._mcBorder, _loc2.bordercolor);
        this.setMovieClipColor(this._mcMapBorder, _loc2.bordercolor);
        this.setMovieClipColor(this._mcGrid, _loc2.gridcolor);
        this.setMovieClipColor(this._mcMapBackground, _loc2.bgcolor);
    };
    _loc1.drawGrid = function (bZoomAccept)
    {
        if (bZoomAccept == undefined)
        {
            bZoomAccept = true;
        } // end if
        this._mcGrid.clear();
        if (this._bShowGrid && bZoomAccept)
        {
            for (var _loc3 = (this._nMapWidth - this.virtualWPage) / 2; _loc3 > 0; _loc3 = _loc3 - this.virtualWPage)
            {
                this.drawRoundRect(this._mcGrid, _loc3, 0, 1, this._nMapHeight, 0, 0);
            } // end of for
            for (var _loc3 = (this._nMapWidth + this.virtualWPage) / 2; _loc3 < this._nMapWidth; _loc3 = _loc3 + this.virtualWPage)
            {
                this.drawRoundRect(this._mcGrid, _loc3, 0, 1, this._nMapHeight, 0, 0);
            } // end of for
            for (var _loc4 = (this._nMapHeight - this.virtualHPage) / 2; _loc4 > 0; _loc4 = _loc4 - this.virtualHPage)
            {
                this.drawRoundRect(this._mcGrid, 0, _loc4, this._nMapWidth, 1, 0, 0);
            } // end of for
            for (var _loc4 = (this._nMapHeight + this.virtualHPage) / 2; _loc4 < this._nMapHeight; _loc4 = _loc4 + this.virtualHPage)
            {
                this.drawRoundRect(this._mcGrid, 0, _loc4, this._nMapWidth, 1, 0, 0);
            } // end of for
        } // end if
    };
    _loc1.setZoom = function ()
    {
        this.setMapPosition(this._nXCurrent, this._nYCurrent);
        this.drawGrid(true);
        this.dispatchEvent({type: "zoom"});
    };
    _loc1.moveMap = function (nXWay, nYWay)
    {
        this.setMapPosition(this._nXCurrent + nXWay, this._nYCurrent + nYWay);
    };
    _loc1.applyInteractionMode = function ()
    {
        delete this._oLastCoordsOver;
        switch (this._sInteractionMode)
        {
            case "move":
            {
                this._btnNW.enabled = true;
                this._btnN.enabled = true;
                this._btnNE.enabled = true;
                this._btnW.enabled = true;
                this._btnE.enabled = true;
                this._btnSW.enabled = true;
                this._btnS.enabled = true;
                this._btnSE.enabled = true;
                break;
            } 
            case "zoom+":
            case "zoom-":
            case "select":
            {
                this._btnNW.enabled = false;
                this._btnN.enabled = false;
                this._btnNE.enabled = false;
                this._btnW.enabled = false;
                this._btnE.enabled = false;
                this._btnSW.enabled = false;
                this._btnS.enabled = false;
                this._btnSE.enabled = false;
                break;
            } 
        } // End of switch
    };
    _loc1.getRealFromCoordinates = function (nX, nY)
    {
        var _loc4 = this.virtualWPage * (nX - this._nXCurrent - 5.000000E-001);
        var _loc5 = this.virtualHPage * (nY - this._nYCurrent - 5.000000E-001);
        return ({x: _loc4, y: _loc5});
    };
    _loc1.getCoordinatesFromReal = function (nRealX, nRealY)
    {
        var _loc4 = Math.floor((nRealX + this.virtualWPage * 5.000000E-001) / this.virtualWPage) + this._nXCurrent;
        var _loc5 = Math.floor((nRealY + this.virtualHPage * 5.000000E-001) / this.virtualHPage) + this._nYCurrent;
        return ({x: _loc4, y: _loc5});
    };
    _loc1.getCoordinatesFromRealWithRef = function (nRealX, nRealY)
    {
        var _loc4 = Math.floor((nRealX + this.virtualWPage * 5.000000E-001) / this.virtualWPage) - this._nXRefPress;
        var _loc5 = Math.floor((nRealY + this.virtualHPage * 5.000000E-001) / this.virtualHPage) - this._nYRefPress;
        return ({x: _loc4, y: _loc5});
    };
    _loc1.onMouseDown = function ()
    {
        if (this._sInteractionMode == "move")
        {
            if (this._mcMapBackground.hitTest(_root._xmouse, _root._ymouse, true))
            {
                delete this._oLastCoordsOver;
                var _loc2 = this.getCoordinatesFromReal(this._ldrMap._xmouse, this._ldrMap._ymouse);
                this._nXRefPress = _loc2.x;
                this._nYRefPress = _loc2.y;
                this.gapi.hideTooltip();
                this.gapi.setCursor({iconFile: "MapNavigatorMoveCursor"});
            } // end if
        } // end if
    };
    _loc1.onMouseUp = function ()
    {
        delete this._nXRefPress;
        delete this._nYRefPress;
        this.gapi.removeCursor();
        if (this._mcMapBackground.hitTest(_root._xmouse, _root._ymouse, true))
        {
            if (this._bTimerEnable != true)
            {
                this._bTimerEnable = true;
                ank.utils.Timer.setTimer(this, "mapnavigator", this, this.onClickTimer, ank.gapi.Gapi.DBLCLICK_DELAY);
            }
            else
            {
                this.onClickTimer();
                var _loc2 = this._ldrMap._xmouse;
                var _loc3 = this._ldrMap._ymouse;
                var _loc4 = this.getCoordinatesFromReal(_loc2, _loc3);
                this.dispatchEvent({type: "doubleClick", coordinates: _loc4});
            } // end if
        } // end else if
    };
    _loc1.onMouseMove = function ()
    {
        if (this._mcMapBackground.hitTest(_root._xmouse, _root._ymouse, true))
        {
            var _loc2 = this._ldrMap._xmouse;
            var _loc3 = this._ldrMap._ymouse;
            if (this._nXRefPress == undefined)
            {
                var _loc4 = this.getCoordinatesFromReal(_loc2, _loc3);
                if (this._oLastCoordsOver.x != _loc4.x || this._oLastCoordsOver.y != _loc4.y)
                {
                    var _loc5 = this.getRealFromCoordinates(_loc4.x, _loc4.y);
                    this._ldrMap.localToGlobal(_loc5);
                    this.gapi.showTooltip(_loc4.x + ", " + _loc4.y, _loc5.x, _loc5.y - 20);
                    this.dispatchEvent({type: "overMap", coordinates: _loc4});
                    this._sLastMapEvent = "overMap";
                    this._oLastCoordsOver = _loc4;
                } // end if
            }
            else
            {
                var _loc6 = this.getCoordinatesFromRealWithRef(_loc2, _loc3);
                this.setMapPosition(-_loc6.x, -_loc6.y);
            } // end else if
        }
        else if (this._sLastMapEvent != "outMap")
        {
            this.dispatchEvent({type: "outMap"});
            this._sLastMapEvent = "outMap";
            this.gapi.hideTooltip();
        } // end else if
    };
    _loc1.click = function (oEvent)
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
                var _loc3 = this._ldrMap._xmouse;
                var _loc4 = this._ldrMap._ymouse;
                var _loc5 = this.getCoordinatesFromReal(_loc3, _loc4);
                switch (this._sInteractionMode)
                {
                    case "zoom+":
                    case "zoom-":
                    {
                        this._nZoom = this._nZoom + (this._sInteractionMode == "zoom+" ? (5) : (-5));
                        this.setZoom();
                        break;
                    } 
                    case "select":
                    {
                        this.dispatchEvent({type: "select", coordinates: _loc5});
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
        this.gapi.hideTooltip();
    };
    _loc1.over = function (oEvent)
    {
        this.dispatchEvent(oEvent);
    };
    _loc1.out = function (oEvent)
    {
        this.dispatchEvent(oEvent);
    };
    _loc1.initialization = function (oEvent)
    {
        this.setZoom();
    };
    _loc1.onLoadInit = function (m)
    {
        this.dispatchEvent({type: "xtraLayerLoad", mc: m});
    };
    _loc1.onClickTimer = function ()
    {
        ank.utils.Timer.removeTimer(this, "mapnavigator");
        this._bTimerEnable = false;
    };
    _loc1.addProperty("virtualHPage", _loc1.__get__virtualHPage, function ()
    {
    });
    _loc1.addProperty("virtualWPage", _loc1.__get__virtualWPage, function ()
    {
    });
    _loc1.addProperty("contentPath", _loc1.__get__contentPath, _loc1.__set__contentPath);
    _loc1.addProperty("wPage", _loc1.__get__wPage, _loc1.__set__wPage);
    _loc1.addProperty("hPage", _loc1.__get__hPage, _loc1.__set__hPage);
    _loc1.addProperty("interactionMode", _loc1.__get__interactionMode, _loc1.__set__interactionMode);
    _loc1.addProperty("showGrid", _loc1.__get__showGrid, _loc1.__set__showGrid);
    _loc1.addProperty("loaderMap", _loc1.__get__loaderMap, function ()
    {
    });
    _loc1.addProperty("buttonMargin", _loc1.__get__buttonMargin, _loc1.__set__buttonMargin);
    _loc1.addProperty("currentX", _loc1.__get__currentX, function ()
    {
    });
    _loc1.addProperty("zoom", _loc1.__get__zoom, _loc1.__set__zoom);
    _loc1.addProperty("currentY", _loc1.__get__currentY, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.MapNavigator = function ()
    {
        super();
    }).CLASS_NAME = "MapNavigator";
    _loc1._nButtonMargin = 5;
    _loc1._bShowGrid = true;
    _loc1._nZoom = 50;
    _loc1._nWPage = 10;
    _loc1._nHPage = 10;
    _loc1._sInteractionMode = "move";
    _loc1._nXCurrent = 0;
    _loc1._nYCurrent = 0;
} // end if
#endinitclip
