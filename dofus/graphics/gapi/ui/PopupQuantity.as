// Action script...

// [Initial MovieClip Action of sprite 980]
#initclip 194
class dofus.graphics.gapi.ui.PopupQuantity extends ank.gapi.core.UIAdvancedComponent
{
    var __get__value, __get__useAllStage, addToQueue, _winBackground, _bgHidder, _xmouse, _ymouse, gapi, _oParams, dispatchEvent, unloadThis, __set__useAllStage, __set__value;
    function PopupQuantity()
    {
        super();
    } // End of the function
    function set value(nValue)
    {
        _nValue = nValue;
        //return (this.value());
        null;
    } // End of the function
    function set useAllStage(bUseAllStage)
    {
        _bUseAllStage = bUseAllStage;
        //return (this.useAllStage());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.PopupQuantity.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _winBackground.addEventListener("complete", this);
        _bgHidder.addEventListener("click", this);
        Key.addListener(this);
    } // End of the function
    function initWindowContent()
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._btnOk.addEventListener("click", this);
        _loc2._txtInput.restrict = "0-9";
        _loc2._txtInput.text = _nValue;
        Selection.setFocus(_loc2._txtInput);
    } // End of the function
    function placeWindow()
    {
        var _loc3 = _xmouse - _winBackground.__get__width();
        var _loc2 = _ymouse - _winBackground._height;
        var _loc4 = _bUseAllStage ? (Stage.width) : (gapi.screenWidth);
        var _loc5 = _bUseAllStage ? (Stage.height) : (gapi.screenHeight);
        if (_loc3 < 0)
        {
            _loc3 = 0;
        } // end if
        if (_loc2 < 0)
        {
            _loc2 = 0;
        } // end if
        if (_loc3 > _loc4 - _winBackground.__get__width())
        {
            _loc3 = _loc4 - _winBackground.__get__width();
        } // end if
        if (_loc2 > _loc5 - _winBackground.__get__height())
        {
            _loc2 = _loc5 - _winBackground.__get__height();
        } // end if
        _winBackground._x = _loc3;
        _winBackground._y = _loc2;
    } // End of the function
    function validate()
    {
        Key.removeListener(this);
        this.dispatchEvent({type: "validate", value: Number(_winBackground.content._txtInput.text), params: _oParams});
    } // End of the function
    function complete(oEvent)
    {
        this.placeWindow();
        this.addToQueue({object: this, method: initWindowContent});
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnOk":
            {
                this.validate();
                break;
            } 
            case "_bgHidder":
            {
                break;
            } 
        } // End of switch
        this.unloadThis();
    } // End of the function
    function onKeyDown()
    {
        if (Key.isDown(13))
        {
            this.validate();
            this.unloadThis();
        } // end if
    } // End of the function
    static var CLASS_NAME = "PopupQuantity";
    var _nValue = 0;
    var _bUseAllStage = false;
} // End of Class
#endinitclip
