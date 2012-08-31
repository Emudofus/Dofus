// Action script...

// [Initial MovieClip Action of sprite 973]
#initclip 185
class ank.gapi.Gapi extends ank.utils.QueueEmbedMovieClip
{
    var _oAPI, __get__api, _nScreenWidth, _nScreenHeight, createEmptyMovieClip, _oUIComponentsList, _eaUIComponentsInstances, _mcLayer_Popup, _nLastSetCursorTimer, _mcLayer_Cursor, dispatchEvent, _sLastAutoHideComponent, _mcLayer_UI_Top, _mcLayer_UI, __set__api, __get__screenHeight, __get__screenWidth;
    function Gapi()
    {
        super();
        this.initialize();
    } // End of the function
    function set api(oAPI)
    {
        _oAPI = oAPI;
        //return (this.api());
        null;
    } // End of the function
    function get api()
    {
        return (_oAPI);
    } // End of the function
    function get screenWidth()
    {
        return (_nScreenWidth == undefined ? (Stage.width) : (_nScreenWidth));
    } // End of the function
    function get screenHeight()
    {
        return (_nScreenHeight == undefined ? (Stage.height) : (_nScreenHeight));
    } // End of the function
    function clear()
    {
        this.createEmptyMovieClip("_mcLayer_UI", 10);
        this.createEmptyMovieClip("_mcLayer_UI_Top", 20);
        this.createEmptyMovieClip("_mcLayer_Popup", 30);
        this.createEmptyMovieClip("_mcLayer_Cursor", 40);
        _oUIComponentsList = new Object();
        _eaUIComponentsInstances = new ank.utils.ExtendedArray();
    } // End of the function
    function setScreenSize(nWidth, nHeight)
    {
        _nScreenWidth = nWidth;
        _nScreenHeight = nHeight;
    } // End of the function
    function createPopupMenu()
    {
        if (_mcLayer_Popup._mcPopupMenu != undefined)
        {
            _mcLayer_Popup._mcPopupMenu.removeMovieClip();
        } // end if
        (ank.gapi.controls.PopupMenu)(_mcLayer_Popup.attachMovie("PopupMenu", "_mcPopupMenu", _mcLayer_Popup.getNextHighestDepth(), {styleName: "BrownPopupMenu", gapi: this}));
        return (_mcLayer_Popup._mcPopupMenu);
    } // End of the function
    function showFixedTooltip(sText, xORmc, y, oParams, sName)
    {
        var _loc12;
        if (sText == undefined)
        {
            return;
        } // end if
        if (typeof(xORmc) == "movieclip")
        {
            var _loc3 = xORmc;
            var _loc4 = {x: _loc3._x, y: _loc3._y};
            _loc3._parent.localToGlobal(_loc4);
            _loc12 = _loc4.x;
            y = y + _loc4.y;
        }
        else
        {
            _loc12 = Number(xORmc);
        } // end else if
        if (_mcLayer_Popup["_mcToolTip" + sName] != undefined)
        {
            var _loc2 = _mcLayer_Popup["_mcToolTip" + sName];
            _loc2.params = oParams;
            _loc2.x = _loc12;
            _loc2.y = y;
            _loc2.text = sText;
        }
        else
        {
            _mcLayer_Popup.attachMovie("ToolTip", "_mcToolTip" + sName, _mcLayer_Popup.getNextHighestDepth(), {text: sText, x: _loc12, y: y, params: oParams, gapi: this});
        } // end else if
    } // End of the function
    function showTooltip(sText, xORmc, y, oParams, sStyleName)
    {
        var _loc12;
        if (sText == undefined)
        {
            return;
        } // end if
        if (typeof(xORmc) == "movieclip")
        {
            var _loc3 = xORmc;
            var _loc4 = {x: _loc3._x, y: _loc3._y};
            _loc3._parent.localToGlobal(_loc4);
            _loc12 = _loc4.x;
            y = y + _loc4.y;
        }
        else
        {
            _loc12 = Number(xORmc);
        } // end else if
        if (_mcLayer_Popup._mcToolTip != undefined)
        {
            var _loc2 = _mcLayer_Popup._mcToolTip;
            _loc2.params = oParams;
            _loc2.x = _loc12;
            _loc2.y = y;
            _loc2.text = sText;
        }
        else
        {
            _mcLayer_Popup.attachMovie("ToolTip", "_mcToolTip", _mcLayer_Popup.getNextHighestDepth(), {text: sText, x: _loc12, y: y, params: oParams, gapi: this, styleName: sStyleName});
        } // end else if
    } // End of the function
    function hideTooltip()
    {
        _mcLayer_Popup._mcToolTip.removeMovieClip();
    } // End of the function
    function setCursor(oData, oAlignment)
    {
        _nLastSetCursorTimer = getTimer();
        this.removeCursor();
        if (oAlignment == undefined)
        {
            oAlignment = new Object();
        } // end if
        oAlignment.width = oAlignment.width != undefined ? (oAlignment.width) : (ank.gapi.Gapi.CURSOR_MAX_SIZE);
        oAlignment.height = oAlignment.height != undefined ? (oAlignment.height) : (ank.gapi.Gapi.CURSOR_MAX_SIZE);
        oAlignment.x = oAlignment.x != undefined ? (oAlignment.x) : (ank.gapi.Gapi.CURSOR_CENTER[0]);
        oAlignment.y = oAlignment.y != undefined ? (oAlignment.y) : (ank.gapi.Gapi.CURSOR_CENTER[1]);
        var _loc3 = (ank.gapi.controls.Container)(_mcLayer_Cursor.attachMovie("Container", "cursor1", 10));
        _loc3.setSize(oAlignment.width, oAlignment.height);
        _loc3.move(oAlignment.x, oAlignment.y);
        _loc3.__set__contentData(oData);
        _oCursorAligment = oAlignment;
        _oCursorData = oData;
        _mcLayer_Cursor.startDrag(true);
    } // End of the function
    function setCursorForbidden(bForbidden, sCursorFile)
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
            if (_mcLayer_Cursor.mcForbidden == undefined)
            {
                var _loc2 = _mcLayer_Cursor.attachMovie("Loader", "mcForbidden", 20, {scaleContent: true});
                _loc2.setSize(_oCursorAligment.width, _oCursorAligment.height);
                _loc2.move(_oCursorAligment.x, _oCursorAligment.y);
                _loc2.contentPath = sCursorFile;
            } // end if
        }
        else
        {
            _mcLayer_Cursor.mcForbidden.removeMovieClip();
        } // end else if
    } // End of the function
    function getCursor()
    {
        return (_oCursorData);
    } // End of the function
    function isCursorHidden()
    {
        return (_mcLayer_Cursor.cursor1 == undefined);
    } // End of the function
    function removeCursor(bDispatchEvent)
    {
        this.hideCursor(bDispatchEvent);
        if (_oCursorData == undefined)
        {
            return (false);
        } // end if
        delete this._oCursorData;
        return (true);
    } // End of the function
    function hideCursor(bDispatchEvent)
    {
        this.setCursorForbidden(false);
        _mcLayer_Cursor.stopDrag();
        _mcLayer_Cursor.cursor1.removeMovieClip();
        if (bDispatchEvent == true)
        {
            this.dispatchEvent({type: "removeCursor"});
        } // end if
    } // End of the function
    function unloadLastUIAutoHideComponent()
    {
        return (this.unloadUIComponent(_sLastAutoHideComponent));
    } // End of the function
    function loadUIAutoHideComponent(sLink, sInstanceName, oComponentParams, oUIParams)
    {
        if (_sLastAutoHideComponent != sLink)
        {
            this.unloadUIComponent(_sLastAutoHideComponent);
        } // end if
        _sLastAutoHideComponent = sLink;
        return (this.loadUIComponent(sLink, sInstanceName, oComponentParams, oUIParams));
    } // End of the function
    function loadUIComponent(sLink, sInstanceName, oComponentParams, oUIParams)
    {
        var _loc10;
        var _loc9;
        var _loc6;
        if (oUIParams.bForceLoad == undefined)
        {
            _loc10 = false;
        }
        else
        {
            _loc10 = oUIParams.bForceLoad;
        } // end else if
        if (oUIParams.bStayIfPresent == undefined)
        {
            _loc9 = false;
        }
        else
        {
            _loc9 = oUIParams.bStayIfPresent;
        } // end else if
        if (oUIParams.bAlwaysOnTop == undefined)
        {
            _loc6 = false;
        }
        else
        {
            _loc6 = oUIParams.bAlwaysOnTop;
        } // end else if
        if (sLink.substring(0, 3) == "Ask")
        {
            _loc6 = true;
        } // end if
        if (_oUIComponentsList[sInstanceName] != undefined)
        {
            if (_loc9)
            {
                var _loc8 = _oUIComponentsList[sInstanceName];
                for (var _loc5 in oComponentParams)
                {
                    _loc8[_loc5] = oComponentParams[_loc5];
                } // end of for...in
                return (null);
            } // end if
            this.unloadUIComponent(sInstanceName);
            if (!_loc10)
            {
                return (null);
            } // end if
        } // end if
        if (oComponentParams == undefined)
        {
            oComponentParams = new Object();
        } // end if
        oComponentParams.api = _oAPI;
        oComponentParams.gapi = this;
        oComponentParams.instanceName = sInstanceName;
        var _loc7;
        if (_loc6)
        {
            _loc7 = _mcLayer_UI_Top;
        }
        else
        {
            _loc7 = _mcLayer_UI;
        } // end else if
        _loc8 = _loc7.attachMovie("UI_" + sLink, sInstanceName, _loc7.getNextHighestDepth(), oComponentParams);
        _oUIComponentsList[sInstanceName] = _loc8;
        _eaUIComponentsInstances.push({name: sInstanceName});
        return (_loc8);
    } // End of the function
    function unloadUIComponent(sInstanceName)
    {
        var _loc2 = this.getUIComponent(sInstanceName);
        delete _oUIComponentsList[sInstanceName];
        var _loc3 = _eaUIComponentsInstances.findFirstItem("name", sInstanceName);
        if (_loc3.index != -1)
        {
            _eaUIComponentsInstances.removeItems(_loc3.index, 1);
        } // end if
        if (_loc2 == undefined)
        {
            return (false);
        } // end if
        _loc2.destroy();
        Key.removeListener(_loc2);
        _loc2.removeMovieClip();
        return (true);
    } // End of the function
    function getUIComponent(sInstanceName)
    {
        var _loc2 = _mcLayer_UI[sInstanceName];
        return (_loc2 == undefined ? (_mcLayer_UI_Top[sInstanceName]) : (_loc2));
    } // End of the function
    function callCloseOnLastUI(nIndex)
    {
        if (nIndex == undefined)
        {
            nIndex = _eaUIComponentsInstances.length - 1;
        } // end if
        if (nIndex < 0)
        {
            return (false);
        } // end if
        if (isNaN(nIndex))
        {
            return (false);
        } // end if
        var _loc3 = this.getUIComponent(_eaUIComponentsInstances[nIndex].name);
        if (_loc3.callClose() == true)
        {
            return (true);
        }
        else
        {
            return (this.callCloseOnLastUI(nIndex - 1));
        } // end else if
    } // End of the function
    function initialize()
    {
        this.clear();
        ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function addDragClip()
    {
    } // End of the function
    function removeDragClip()
    {
    } // End of the function
    function onMouseUp()
    {
        if (_oCursorData == undefined)
        {
            return;
        } // end if
        var _loc2 = getTimer() - _nLastSetCursorTimer;
        if (isNaN(_loc2))
        {
            return;
        } // end if
        if (_loc2 < ank.gapi.Gapi.MAX_DELAY_CURSOR)
        {
            return;
        } // end if
        this.hideCursor(true);
    } // End of the function
    static var MAX_DELAY_CURSOR = 400;
    static var CURSOR_MAX_SIZE = 40;
    static var CURSOR_CENTER = [-20, -20];
    var _oDragClipsList = null;
    var _oCursorData = null;
    var _oCursorAligment = null;
} // End of Class
#endinitclip
