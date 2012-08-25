// Action script...

// [Initial MovieClip Action of sprite 20598]
#initclip 119
if (!ank.gapi.Gapi)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.Gapi = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__set__api = function (oAPI)
    {
        this._oAPI = oAPI;
        //return (this.api());
    };
    _loc1.__get__api = function ()
    {
        return (this._oAPI);
    };
    _loc1.__get__screenWidth = function ()
    {
        return (this._nScreenWidth == undefined ? (Stage.width) : (this._nScreenWidth));
    };
    _loc1.__get__screenHeight = function ()
    {
        return (this._nScreenHeight == undefined ? (Stage.height) : (this._nScreenHeight));
    };
    _loc1.clear = function ()
    {
        this.createEmptyMovieClip("_mcLayer_UI", 10).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/UI"];
        this.createEmptyMovieClip("_mcLayer_UI_Top", 20).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/UITop"];
        this.createEmptyMovieClip("_mcLayer_UI_Ultimate", 30).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/UIUltimate"];
        this.createEmptyMovieClip("_mcLayer_Popup", 40).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/Popup"];
        this.createEmptyMovieClip("_mcLayer_Cursor", 50).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["GAPI/Cursor"];
        this._oUIComponentsList = new Object();
        this._eaUIComponentsInstances = new ank.utils.ExtendedArray();
    };
    _loc1.setScreenSize = function (nWidth, nHeight)
    {
        this._nScreenWidth = nWidth;
        this._nScreenHeight = nHeight;
    };
    _loc1.createPopupMenu = function (sStyleName)
    {
        var _loc3 = this.pmPopupMenu;
        if (sStyleName == undefined)
        {
            sStyleName = "BrownPopupMenu";
        } // end if
        if (this.nPopupMenuCnt == undefined)
        {
            this.nPopupMenuCnt = 0;
        } // end if
        var _loc4 = this.nPopupMenuCnt++;
        this.pmPopupMenu = (ank.gapi.controls.PopupMenu)(this._mcLayer_Popup.attachMovie("PopupMenu", "_mcPopupMenu" + _loc4, _loc4, {styleName: sStyleName, gapi: this}));
        _loc3.removeMovieClip();
        return (this.pmPopupMenu);
    };
    _loc1.removePopupMenu = function ()
    {
        this.pmPopupMenu.removeMovieClip();
    };
    _loc1.showFixedTooltip = function (sText, xORmc, y, oParams, sName)
    {
        if (sText == undefined)
        {
            return;
        } // end if
        if (typeof(xORmc) == "movieclip")
        {
            var _loc8 = xORmc;
            var _loc9 = {x: _loc8._x, y: _loc8._y};
            _loc8._parent.localToGlobal(_loc9);
            var _loc7 = _loc9.x;
            y = y + _loc9.y;
        }
        else
        {
            _loc7 = Number(xORmc);
        } // end else if
        if (this._mcLayer_Popup["_mcToolTip" + sName] != undefined)
        {
            var _loc10 = this._mcLayer_Popup["_mcToolTip" + sName];
            _loc10.params = oParams;
            _loc10.x = _loc7;
            _loc10.y = y;
            _loc10.text = sText;
        }
        else
        {
            this._mcLayer_Popup.attachMovie("ToolTip", "_mcToolTip" + sName, this._mcLayer_Popup.getNextHighestDepth(), {text: sText, x: _loc7, y: y, params: oParams, gapi: this});
        } // end else if
    };
    _loc1.showTooltip = function (sText, xORmc, y, oParams, sStyleName)
    {
        if (sText == undefined)
        {
            return;
        } // end if
        if (typeof(xORmc) == "movieclip")
        {
            var _loc8 = xORmc;
            var _loc9 = {x: _loc8._x, y: _loc8._y};
            _loc8._parent.localToGlobal(_loc9);
            this.globalToLocal(_loc9);
            var _loc7 = _loc9.x;
            y = y + _loc9.y;
        }
        else
        {
            _loc7 = Number(xORmc);
        } // end else if
        if (this._mcLayer_Popup._mcToolTip != undefined)
        {
            var _loc10 = this._mcLayer_Popup._mcToolTip;
            _loc10.params = oParams;
            _loc10.x = _loc7;
            _loc10.y = y;
            _loc10.text = sText;
        }
        else
        {
            this._mcLayer_Popup.attachMovie("ToolTip", "_mcToolTip", this._mcLayer_Popup.getNextHighestDepth(), {text: sText, x: _loc7, y: y, params: oParams, gapi: this, styleName: sStyleName});
        } // end else if
    };
    _loc1.hideTooltip = function ()
    {
        this._mcLayer_Popup._mcToolTip.removeMovieClip();
    };
    _loc1.setCursor = function (oData, oAlignment)
    {
        this._nLastSetCursorTimer = getTimer();
        this.removeCursor();
        if (oAlignment == undefined)
        {
            oAlignment = new Object();
        } // end if
        oAlignment.width = oAlignment.width != undefined ? (oAlignment.width) : (ank.gapi.Gapi.CURSOR_MAX_SIZE);
        oAlignment.height = oAlignment.height != undefined ? (oAlignment.height) : (ank.gapi.Gapi.CURSOR_MAX_SIZE);
        oAlignment.x = oAlignment.x != undefined ? (oAlignment.x) : (ank.gapi.Gapi.CURSOR_CENTER[0]);
        oAlignment.y = oAlignment.y != undefined ? (oAlignment.y) : (ank.gapi.Gapi.CURSOR_CENTER[1]);
        var _loc4 = (ank.gapi.controls.Container)(this._mcLayer_Cursor.attachMovie("Container", "cursor1", 10));
        _loc4.setSize(oAlignment.width, oAlignment.height);
        _loc4.move(oAlignment.x, oAlignment.y);
        _loc4.contentData = oData;
        this._oCursorAligment = oAlignment;
        this._oCursorData = oData;
        this._mcLayer_Cursor.startDrag(true);
    };
    _loc1.setCursorForbidden = function (bForbidden, sCursorFile)
    {
        if (this.isCursorHidden())
        {
            return;
        } // end if
        if (bForbidden == undefined)
        {
            bForbidden = false;
        } // end if
        if (bForbidden)
        {
            if (this._mcLayer_Cursor.mcForbidden == undefined)
            {
                var _loc4 = this._mcLayer_Cursor.attachMovie("Loader", "mcForbidden", 20, {scaleContent: true});
                _loc4.setSize(this._oCursorAligment.width, this._oCursorAligment.height);
                _loc4.move(this._oCursorAligment.x, this._oCursorAligment.y);
                _loc4.contentPath = sCursorFile;
            } // end if
        }
        else
        {
            this._mcLayer_Cursor.mcForbidden.removeMovieClip();
        } // end else if
    };
    _loc1.getCursor = function ()
    {
        return (this._oCursorData);
    };
    _loc1.isCursorHidden = function ()
    {
        return (this._mcLayer_Cursor.cursor1 == undefined);
    };
    _loc1.removeCursor = function (bDispatchEvent)
    {
        this.hideCursor(bDispatchEvent);
        if (this._oCursorData == undefined)
        {
            return (false);
        } // end if
        delete this._oCursorData;
        return (true);
    };
    _loc1.hideCursor = function (bDispatchEvent)
    {
        this.setCursorForbidden(false);
        this._mcLayer_Cursor.stopDrag();
        this._mcLayer_Cursor.cursor1.removeMovieClip();
        if (bDispatchEvent == true)
        {
            this.dispatchEvent({type: "removeCursor"});
        } // end if
    };
    _loc1.unloadLastUIAutoHideComponent = function ()
    {
        return (this.unloadUIComponent(this._sLastAutoHideComponent));
    };
    _loc1.loadUIAutoHideComponent = function (sLink, sInstanceName, oComponentParams, oUIParams)
    {
        if (this._sLastAutoHideComponent != sLink)
        {
            this.unloadUIComponent(this._sLastAutoHideComponent);
        } // end if
        this._sLastAutoHideComponent = sLink;
        return (this.loadUIComponent(sLink, sInstanceName, oComponentParams, oUIParams));
    };
    _loc1.loadUIComponent = function (sLink, sInstanceName, oComponentParams, oUIParams)
    {
        if (oUIParams.bForceLoad == undefined)
        {
            var _loc6 = false;
        }
        else
        {
            _loc6 = oUIParams.bForceLoad;
        } // end else if
        if (oUIParams.bStayIfPresent == undefined)
        {
            var _loc7 = false;
        }
        else
        {
            _loc7 = oUIParams.bStayIfPresent;
        } // end else if
        if (oUIParams.bAlwaysOnTop == undefined)
        {
            var _loc8 = false;
        }
        else
        {
            _loc8 = oUIParams.bAlwaysOnTop;
        } // end else if
        if (oUIParams.bUltimateOnTop == undefined)
        {
            var _loc9 = false;
        }
        else
        {
            _loc9 = oUIParams.bUltimateOnTop;
        } // end else if
        if (sLink.substring(0, 3) == "Ask")
        {
            _loc9 = true;
        } // end if
        if (this._oUIComponentsList[sInstanceName] != undefined)
        {
            if (_loc7)
            {
                var _loc10 = this._oUIComponentsList[sInstanceName];
                for (var k in oComponentParams)
                {
                    _loc10[k] = oComponentParams[k];
                } // end of for...in
                return (null);
            } // end if
            this.unloadUIComponent(sInstanceName);
            if (!_loc6)
            {
                return (null);
            } // end if
        } // end if
        if (oComponentParams == undefined)
        {
            oComponentParams = new Object();
        } // end if
        oComponentParams.api = this._oAPI;
        oComponentParams.gapi = this;
        oComponentParams.instanceName = sInstanceName;
        if (_loc8)
        {
            var _loc11 = this._mcLayer_UI_Top;
        }
        else if (_loc9)
        {
            _loc11 = this._mcLayer_UI_Ultimate;
        }
        else
        {
            _loc11 = this._mcLayer_UI;
        } // end else if
        var _loc12 = _loc11.attachMovie("UI_" + sLink, sInstanceName, _loc11.getNextHighestDepth(), oComponentParams);
        this._oUIComponentsList[sInstanceName] = _loc12;
        this._eaUIComponentsInstances.push({name: sInstanceName});
        return (_loc12);
    };
    _loc1.unloadUIComponent = function (sInstanceName)
    {
        var _loc3 = this.getUIComponent(sInstanceName);
        delete this._oUIComponentsList[sInstanceName];
        var _loc4 = this._eaUIComponentsInstances.findFirstItem("name", sInstanceName);
        if (_loc4.index != -1)
        {
            this._eaUIComponentsInstances.removeItems(_loc4.index, 1);
        } // end if
        if (_loc3 == undefined)
        {
            return (false);
        } // end if
        _loc3.destroy();
        Key.removeListener(_loc3);
        this.api.kernel.KeyManager.removeShortcutsListener(_loc3);
        this.api.kernel.KeyManager.removeKeysListener(_loc3);
        _loc3.removeMovieClip();
        return (true);
    };
    _loc1.getUIComponent = function (sInstanceName)
    {
        var _loc3 = this._mcLayer_UI[sInstanceName];
        if (_loc3 == undefined)
        {
            _loc3 = this._mcLayer_UI_Top[sInstanceName];
        } // end if
        if (_loc3 == undefined)
        {
            _loc3 = this._mcLayer_UI_Ultimate[sInstanceName];
        } // end if
        if (_loc3 == undefined)
        {
            return (null);
        } // end if
        return (_loc3);
    };
    _loc1.callCloseOnLastUI = function (nIndex)
    {
        if (nIndex == undefined)
        {
            nIndex = this._eaUIComponentsInstances.length - 1;
        } // end if
        if (nIndex < 0)
        {
            return (false);
        } // end if
        if (_global.isNaN(nIndex))
        {
            return (false);
        } // end if
        var _loc3 = this.getUIComponent(this._eaUIComponentsInstances[nIndex].name);
        if (_loc3.callClose() == true)
        {
            return (true);
        }
        else
        {
            return (this.callCloseOnLastUI(nIndex - 1));
        } // end else if
    };
    _loc1.initialize = function ()
    {
        this.clear();
        ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.addDragClip = function ()
    {
    };
    _loc1.removeDragClip = function ()
    {
    };
    _loc1.onMouseUp = function ()
    {
        if (this._oCursorData == undefined)
        {
            return;
        } // end if
        var _loc2 = getTimer() - this._nLastSetCursorTimer;
        if (_global.isNaN(_loc2))
        {
            return;
        } // end if
        if (_loc2 < ank.gapi.Gapi.MAX_DELAY_CURSOR)
        {
            return;
        } // end if
        this.hideCursor(true);
    };
    _loc1.addProperty("screenHeight", _loc1.__get__screenHeight, function ()
    {
    });
    _loc1.addProperty("api", _loc1.__get__api, _loc1.__set__api);
    _loc1.addProperty("screenWidth", _loc1.__get__screenWidth, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.Gapi = function ()
    {
        super();
        this.initialize();
    }).MAX_DELAY_CURSOR = 250;
    (_global.ank.gapi.Gapi = function ()
    {
        super();
        this.initialize();
    }).CURSOR_MAX_SIZE = 40;
    (_global.ank.gapi.Gapi = function ()
    {
        super();
        this.initialize();
    }).CURSOR_CENTER = [-20, -20];
    (_global.ank.gapi.Gapi = function ()
    {
        super();
        this.initialize();
    }).DBLCLICK_DELAY = 250;
    _loc1._oDragClipsList = null;
    _loc1._oCursorData = null;
    _loc1._oCursorAligment = null;
} // end if
#endinitclip
