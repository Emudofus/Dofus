// Action script...

// [Initial MovieClip Action of sprite 1002]
#initclip 219
class dofus.graphics.gapi.ui.KeyCode extends ank.gapi.core.UIAdvancedComponent
{
    var _winCode, addToQueue, __get__title, _nChangeType, __get__changeType, _nSlotsCount, __get__slotsCount, gapi, api, _mcSlotPlacer, _btnNoCode, _btnValidate, _btnClose, _txtDescription, _mcSlots, createEmptyMovieClip, __set__changeType, __set__slotsCount, __set__title;
    function KeyCode()
    {
        super();
    } // End of the function
    function set title(sTitle)
    {
        this.addToQueue({object: this, method: function ()
        {
            _winCode.title = sTitle;
        }});
        //return (this.title());
        null;
    } // End of the function
    function set changeType(nChangeType)
    {
        _nChangeType = nChangeType;
        //return (this.changeType());
        null;
    } // End of the function
    function set slotsCount(nSlotsCount)
    {
        if (nSlotsCount > 8)
        {
            ank.utils.Logger.err("[slotsCount] doit être au max 8");
            return;
        } // end if
        _nSlotsCount = nSlotsCount;
        _aKeyCode = new Array();
        for (var _loc2 = 0; _loc2 < nSlotsCount; ++_loc2)
        {
            _aKeyCode[_loc2] = "_";
        } // end of for
        //return (this.slotsCount());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.KeyCode.CLASS_NAME);
        gapi.getUIComponent("Banner").chatAutoFocus = false;
    } // End of the function
    function destroy()
    {
        gapi.getUIComponent("Banner").chatAutoFocus = true;
    } // End of the function
    function callClose()
    {
        api.network.Key.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        this.drawCodeSlots();
        this.selectNextSlot();
        _mcSlotPlacer._visible = false;
        _btnNoCode._visible = false;
    } // End of the function
    function addListeners()
    {
        for (var _loc3 = 0; _loc3 < 10; ++_loc3)
        {
            var _loc2 = this["_ctrSymbol" + _loc3];
            _loc2.addEventListener("drag", this);
            _loc2.addEventListener("click", this);
            _loc2.addEventListener("dblClick", this);
            _loc2.params = {index: _loc3};
        } // end of for
        Key.addListener(this);
        _btnValidate.addEventListener("click", this);
        _btnNoCode.addEventListener("click", this);
        _btnClose.addEventListener("click", this);
    } // End of the function
    function initTexts()
    {
        switch (_nChangeType)
        {
            case 0:
            {
                _btnValidate.__set__label(api.lang.getText("UNLOCK"));
                _txtDescription.__set__text(api.lang.getText("UNLOCK_INFOS"));
                break;
            } 
            case 1:
            {
                _btnValidate.__set__label(api.lang.getText("CHANGE"));
                _btnNoCode.__set__label(api.lang.getText("NO_CODE"));
                _txtDescription.__set__text(api.lang.getText("LOCK_INFOS"));
                break;
            } 
        } // End of switch
    } // End of the function
    function initData()
    {
        for (var _loc2 = 0; _loc2 < 10; ++_loc2)
        {
            this["_ctrSymbol" + _loc2].contentData = {iconFile: "UI_KeyCodeSymbol" + _loc2, value: String(_loc2)};
        } // end of for
        switch (_nChangeType)
        {
            case 0:
            {
                _btnNoCode._visible = false;
                break;
            } 
            case 1:
            {
                _btnNoCode._visible = true;
                break;
            } 
        } // End of switch
    } // End of the function
    function drawCodeSlots()
    {
        _mcSlots.removeMovieClip();
        this.createEmptyMovieClip("_mcSlots", 10);
        for (var _loc2 = 0; _loc2 < _nSlotsCount; ++_loc2)
        {
            var _loc3 = _mcSlots.attachMovie("Container", "_ctrCode" + _loc2, _loc2, {_x: _loc2 * dofus.graphics.gapi.ui.KeyCode.CODE_SLOT_WIDTH, backgroundRenderer: "UI_KeyCodeContainer", dragAndDrop: true, highlightRenderer: "UI_KeyCodeHighlight", styleName: "none", enabled: true, _width: 30, _height: 30});
            _loc3.addEventListener("drop", this);
            _loc3.addEventListener("drag", this);
            _loc3.params = {index: _loc2};
        } // end of for
        _mcSlots._x = _mcSlotPlacer._x - _mcSlots._width;
        _mcSlots._y = _mcSlotPlacer._y;
    } // End of the function
    function selectPreviousSlot()
    {
        var _loc2 = _nCurrentSelectedSlot;
        --_nCurrentSelectedSlot;
        if (_nCurrentSelectedSlot < 0)
        {
            _nCurrentSelectedSlot = _nSlotsCount - 1;
        } // end if
        this.selectSlot(_loc2, _nCurrentSelectedSlot);
    } // End of the function
    function selectNextSlot()
    {
        var _loc2 = _nCurrentSelectedSlot;
        _nCurrentSelectedSlot = ++_nCurrentSelectedSlot % _nSlotsCount;
        this.selectSlot(_loc2, _nCurrentSelectedSlot);
    } // End of the function
    function selectSlot(nLastSlotID, nSlotID)
    {
        var _loc2 = _mcSlots["_ctrCode" + nLastSlotID];
        _loc2.__set__selected(false);
        _mcSlots["_ctrCode" + nSlotID].selected = true;
    } // End of the function
    function setKeyInCurrentSlot(nKey)
    {
        var _loc3 = _mcSlots["_ctrCode" + _nCurrentSelectedSlot];
        var _loc2 = this["_ctrSymbol" + nKey];
        _loc3.__set__contentData(_loc2.contentData);
        _aKeyCode[_nCurrentSelectedSlot] = nKey;
        this.selectNextSlot();
    } // End of the function
    function validate()
    {
        var _loc3 = true;
        for (var _loc2 = 0; _loc2 < _aKeyCode.length; ++_loc2)
        {
            if (_aKeyCode[_loc2] != "_")
            {
                _loc3 = false;
                continue;
            } // end if
        } // end of for
        api.network.Key.sendKey(_nChangeType, _loc3 ? ("-") : (_aKeyCode.join("")));
    } // End of the function
    function dblClick(oEvent)
    {
        this.click(oEvent);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnNoCode":
            {
                api.network.Key.sendKey(_nChangeType, "-");
                break;
            } 
            case "_btnValidate":
            {
                this.validate();
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            default:
            {
                this.setKeyInCurrentSlot(oEvent.target.params.index);
                break;
            } 
        } // End of switch
    } // End of the function
    function drop(oEvent)
    {
        var _loc2 = gapi.getCursor();
        var _loc4;
        if (_loc2 == undefined)
        {
            return;
        } // end if
        gapi.removeCursor();
        oEvent.target.contentData = _loc2;
        _aKeyCode[oEvent.target.params.index] = _loc2.value;
    } // End of the function
    function drag(oEvent)
    {
        gapi.removeCursor();
        var _loc3 = oEvent.target.contentData;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        gapi.setCursor(_loc3);
        if (oEvent.target._parent != this)
        {
            oEvent.target.contentData = undefined;
            _aKeyCode[oEvent.target.params.index] = "_";
        } // end if
    } // End of the function
    function onKeyUp()
    {
        if (Selection.getFocus() != null)
        {
            return;
        } // end if
        if (Key.getCode() == 46)
        {
            this.setKeyInCurrentSlot();
            return;
        } // end if
        if (Key.getCode() == 32)
        {
            this.setKeyInCurrentSlot();
            return;
        } // end if
        if (Key.getCode() == 39)
        {
            this.selectNextSlot();
            return;
        } // end if
        if (Key.getCode() == 37)
        {
            this.selectPreviousSlot();
            return;
        } // end if
        if (Key.getCode() == 13)
        {
            this.validate();
            return;
        } // end if
        var _loc2 = Key.getAscii() - 48;
        if (_loc2 < 0 || _loc2 > 9)
        {
            return;
        } // end if
        this.setKeyInCurrentSlot(_loc2);
    } // End of the function
    static var CLASS_NAME = "KeyCode";
    static var CODE_SLOT_WIDTH = 40;
    var _aKeyCode = new Array();
    var _nCurrentSelectedSlot = -1;
} // End of Class
#endinitclip
